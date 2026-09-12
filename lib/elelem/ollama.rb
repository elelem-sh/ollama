# frozen_string_literal: true

require "elelem"
require "json"
require "net/http"
require "uri"

require_relative "ollama/version"
require_relative "ollama/provider"

Elelem.configure do |config|
  config.provider(:ollama) do
    Elelem::Ollama::Provider.new(
      model: ENV.fetch("OLLAMA_MODEL", "gpt-oss:latest"),
      host: ENV.fetch("OLLAMA_HOST", "localhost:11434"),
      think: ENV.fetch("OLLAMA_THINK", nil),
      keep_alive: ENV.fetch("OLLAMA_KEEP_ALIVE", nil)
    )
  end
end
