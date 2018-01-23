SHELL       := /usr/bin/env bash
tstArgs     :=
tstPattern  := **/*.md _layouts/*.html _includes/*.html *.html

.PHONY: fix-markdown
fix-markdown:
  @echo "--> Fixing Messy Formatting.."
  @node_modules/.bin/mdast --output .

.PHONY: test-inconsiderate
test-inconsiderate:
  @echo "--> Searching for Inconsiderate Writing (non-fatal).."
  @node_modules/.bin/alex $(tstArgs) || true

.PHONY: test-spelling
test-spelling:
  @$(MAKE) test-spelling-interactive tstArgs=--report

.PHONY: test-spelling-interactive
test-spelling-interactive:
  @echo "--> Searching for Spelling Errors.."
  @node_modules/.bin/mdspell \
  $(tstArgs) \
    --en-us \
    --ignore-numbers \
    --ignore-acronyms \
    $(tstPattern)

.PHONY: test-markdown-lint
test-markdown-lint:
  @echo "--> Searching for Messy Formatting.."
  @node_modules/.bin/mdast --frail $(tstArgs) .

.PHONY: test
test: test-inconsiderate test-spelling test-markdown-lint
  @echo "All okay : )"
