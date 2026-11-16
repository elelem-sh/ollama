As a `person who wants to use a local Ollama model with elelem`, I
`want a README in the elelem-ollama repository`, so that `I can
install it and pick a model and host without reading the code`.

# SYNOPSIS

Add a short README.

# DESCRIPTION

The repository has no README. It should cover:

* Install, and that Ollama must be running with the model pulled.
* Select the provider: `elelem chat -p ollama`, and `--model NAME`,
  which overrides `OLLAMA_MODEL`.
* Environment variables: `OLLAMA_MODEL` (default `gpt-oss:latest`),
  `OLLAMA_HOST` (default `localhost:11434`), `OLLAMA_THINK` and
  `OLLAMA_KEEP_ALIVE`, plus any added by the options story.
* A link to https://elelem.sh/plugins/ollama/ for the full guide.

The elelem.sh plugin page can be the source for the text. Show
commands without a leading `$`.

# SEE ALSO

* [ ] lib/elelem/ollama.rb:12-19 - provider block and environment
* [ ] exe/elelem-ollama
* [ ] .agents/backlog/001-think-and-model-options.md
* [ ] https://elelem.sh/plugins/ollama/
* [ ] Formerly elelem-sh/elelem.sh#23

# Tasks

* [ ] TBD (filled in design mode)

# Acceptance Criteria

* [ ] README.md exists and covers install, provider selection, and
      every environment variable the provider reads
* [ ] Defaults in the README match lib/elelem/ollama.rb
* [ ] Commands have no leading `$`
