As a `user reading the elelem-ollama changelog`, I `want the release
notes to state the elelem version the gem really requires`, so that `I
do not install it against a core it cannot load with`.

# SYNOPSIS

Correct the elelem constraint in the 0.3.0 release notes before
merging.

# DESCRIPTION

The open release PR for 0.3.0 (release-please branch, commit 3412b5c)
adds a CHANGELOG.md whose only bug fix reads "require elelem ~> 0.12,
the floor builtins/skills actually need" (8c52b47). The gemspec on
main requires `>= 0.13, < 1` (elelem-ollama.gemspec:31). 8cf5b67
raised the floor to `~> 0.13` and 2fd539c (a chore, so it is not in
the changelog) widened it to `< 1`; neither change shows in the notes.
The release notes would tell users 0.12 works when it does not.

Fix the CHANGELOG.md in the release PR by hand before merging, so the
entry states `>= 0.13, < 1`.

# SEE ALSO

* [ ] elelem-ollama.gemspec:31 - elelem dependency
* [ ] release-please-config.json
* [ ] Formerly elelem-sh/elelem.sh#55

# Tasks

* [ ] TBD (filled in design mode)

# Acceptance Criteria

* [ ] The 0.3.0 changelog states the elelem requirement the gemspec
      has (`>= 0.13, < 1`)
* [ ] No line in the changelog says `~> 0.12`
* [ ] 0.3.0 is released with the corrected changelog
