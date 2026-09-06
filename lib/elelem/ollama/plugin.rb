# frozen_string_literal: true

require "elelem"
require_relative "../ollama"

Elelem::Providers.register(:ollama) do
  Elelem::Ollama::Client.new(
    model: ENV.fetch("OLLAMA_MODEL", "gpt-oss:latest"),
    host: ENV.fetch("OLLAMA_HOST", "localhost:11434")
  )
end
