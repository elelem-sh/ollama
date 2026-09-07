# frozen_string_literal: true

require "elelem"
require "json"
require "net/http"
require "uri"

require_relative "ollama/version"
require_relative "ollama/client"

Elelem::Providers.register(:ollama) do
  Elelem::Ollama::Client.new(
    model: ENV.fetch("OLLAMA_MODEL", "gpt-oss:latest"),
    host: ENV.fetch("OLLAMA_HOST", "localhost:11434"),
    think: ENV["OLLAMA_THINK"],
    keep_alive: ENV["OLLAMA_KEEP_ALIVE"]
  )
end
