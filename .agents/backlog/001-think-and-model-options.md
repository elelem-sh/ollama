As a `user running models through Ollama`, I `want OLLAMA_THINK and
model options such as context size to reach Ollama in the form it
expects`, so that `thinking and num_ctx work without editing code`.

# SYNOPSIS

Send `think` as a boolean or level, and let users set Ollama options.

# DESCRIPTION

`OLLAMA_THINK` is read with `ENV.fetch` and passed through unchanged
(lib/elelem/ollama.rb:16), so the request body carries a string such as
`"true"` (provider.rb:72). Ollama's `/api/chat` expects `think` to be a
boolean, or `"low"`, `"medium"` or `"high"` for models that take a
level. `"true"` and `"false"` may be rejected or ignored.

The provider accepts `options:` (sent as the request's `options`, for
values such as `num_ctx`, `temperature`, `seed`) and `params:` (merged
into the top level of the request body) (provider.rb:31-32, :66-75).
Nothing sets either: the provider block in lib/elelem/ollama.rb passes
only model, host, think and keep_alive. A user cannot raise the context
window without writing a plugin, and Ollama's default context is small
for an agent with tools.

Proposed:

* Map `OLLAMA_THINK=true|false` (any case) to booleans; pass `low`,
  `medium` and `high` through; reject or warn on anything else.
* Expose options through environment variables, for example
  `OLLAMA_NUM_CTX`, and decide in design whether to accept a general
  form (such as `OLLAMA_OPTIONS` as JSON) as well.
* Accept the same values through provider options from core, if core
  passes more than `model:`.

# SEE ALSO

* [ ] lib/elelem/ollama.rb:12-19 - provider block
* [ ] lib/elelem/ollama/provider.rb:26-46 - constructor
* [ ] lib/elelem/ollama/provider.rb:66-76 - build_request_body
* [ ] spec/elelem/ollama/provider_spec.rb
* [ ] Formerly elelem-sh/elelem.sh#27

# Tasks

* [ ] TBD (filled in design mode)

# Acceptance Criteria

* [ ] `OLLAMA_THINK=true` sends `"think": true`; `false` sends `false`
* [ ] `OLLAMA_THINK=high` sends `"think": "high"`
* [ ] An unset `OLLAMA_THINK` sends no `think` key, as today
* [ ] `OLLAMA_NUM_CTX=8192` sends `"options": {"num_ctx": 8192}`
* [ ] Specs check the request body for each case
