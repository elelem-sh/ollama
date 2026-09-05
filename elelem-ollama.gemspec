# frozen_string_literal: true

require_relative "lib/elelem/ollama/version"

Gem::Specification.new do |spec|
  spec.name = "elelem-ollama"
  spec.version = Elelem::Ollama::VERSION
  spec.authors = ["mo khan"]
  spec.email = ["mo@mokhan.ca"]

  spec.summary = "An Ollama provider plugin for elelem."
  spec.description = "An Ollama provider plugin for elelem."
  spec.homepage = "https://src.mokhan.ca/xlgmokha/elelem"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 4.0.0"
  spec.required_rubygems_version = ">= 4.0.0"
  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://git.mokhan.ca/xlgmokha/elelem.git"

  spec.files = [
    "LICENSE.txt",
    "lib/elelem/ollama.rb",
    "lib/elelem/ollama/version.rb",
    "lib/elelem/ollama/client.rb",
    "lib/elelem/ollama/plugin.rb",
  ]
  spec.require_paths = ["lib"]

  spec.add_dependency "elelem", "~> 0.10"
  spec.add_dependency "json", "~> 2.0"
end
