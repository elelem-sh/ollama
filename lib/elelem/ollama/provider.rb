# frozen_string_literal: true

module Elelem
  module Ollama
    class Provider
      def initialize(
        model:,
        host: "localhost:11434",
        think: nil,
        keep_alive: nil,
        options: {},
        params: {},
        read_timeout: 3600,
        open_timeout: 10,
        http: nil
      )
        @uri = normalize_uri(host)
        @model = model
        @think = think
        @keep_alive = keep_alive
        @options = options
        @params = params
        @read_timeout = read_timeout
        @open_timeout = open_timeout
        @http = http
      end

      def fetch(messages, tools = [], &)
        tool_calls = []
        body = build_request_body(messages, tools)

        stream(body) do |event|
          handle_event(event, tool_calls, &)
        end

        tool_calls
      end

      private

      def normalize_uri(host)
        base = host.start_with?("http") ? host : "http://#{host}"
        URI.join(base, "/api/chat")
      end

      def build_request_body(messages, tools)
        {
          model: @model,
          messages: normalize(messages),
          stream: true,
          tools: presence(tools),
          think: @think,
          keep_alive: @keep_alive,
          options: presence(@options)
        }.merge(@params).compact
      end

      def presence(value)
        value unless value.nil? || value.empty?
      end

      def normalize(messages)
        pending = []

        messages.map do |message|
          case message[:role]
          when "assistant" then normalize_calls(message, pending)
          when "tool" then normalize_result(message, pending)
          else message
          end
        end
      end

      def normalize_calls(message, pending)
        calls = message[:tool_calls]
        return message unless calls

        pending.clear
        message.merge(tool_calls: calls.map do |call|
          pending << call[:name]
          { function: { name: call[:name], arguments: call[:arguments] } }
        end)
      end

      def normalize_result(message, pending)
        name = pending.shift
        return message unless name

        message.except(:tool_call_id).merge(tool_name: name)
      end

      def handle_event(event, tool_calls, &block)
        stopped(event["done_reason"])
        message = event["message"] || {}

        unless event["done"]
          block.call(type: "saying", text: message["content"]) if message["content"]
          block.call(type: "thinking", text: message["thinking"]) if message["thinking"]
        end

        return unless message["tool_calls"]

        parsed = parse_tool_calls(message["tool_calls"])
        parsed.each { |tc| block.call(tc.merge(type: "doing")) }
        tool_calls.concat(parsed)
      end

      def stopped(reason)
        raise "the reply hit the output limit (num_predict) before it ended" if reason == "length"
      end

      def stream(body)
        http.post(@uri, body:) do |response|
          Elelem::HTTP.lines(response) { |line| yield JSON.parse(line) }
        end
      end

      def http
        @http ||= Elelem::HTTP.new(read_timeout: @read_timeout, open_timeout: @open_timeout)
      end

      def parse_tool_calls(tool_calls)
        tool_calls.map do |tool_call|
          {
            id: tool_call["id"],
            name: tool_call.dig("function", "name"),
            arguments: tool_call.dig("function", "arguments") || {}
          }
        end
      end
    end
  end
end
