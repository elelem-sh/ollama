# frozen_string_literal: true

require "elelem"
require "elelem/http"
require "json"
require "uri"

require_relative "ollama/version"
require_relative "ollama/provider"

Elelem.configure do |config|
  config.provider(:ollama) do |model: nil, **|
    Elelem::Ollama::Provider.new(
      model: model || ENV.fetch("OLLAMA_MODEL", "gpt-oss:latest"),
      host: ENV.fetch("OLLAMA_HOST", "localhost:11434"),
      think: ENV.fetch("OLLAMA_THINK", nil),
      keep_alive: ENV.fetch("OLLAMA_KEEP_ALIVE", nil)
    )
  end
end
