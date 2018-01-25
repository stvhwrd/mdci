SHELL         := /usr/bin/env bash				# Shell
testArgs      :=								# Project-wide arguments
testPattern   := '**/*.md'						# File pattern to operate on
ignorePattern := '!**/node_modules/**/*.md'		# File pattern to ignore

#---------- Millennial protector ----------#
.PHONY: test-inconsiderate
test-inconsiderate:
	@echo
	@echo "--> Checking for inconsiderate writing..."
	@node_modules/.bin/alex $(testArgs) || true

#---------- Auto spellcheck ----------#
.PHONY: test-spelling
test-spelling:
	@$(MAKE) test-spelling-interactive \
		testArgs=--report

#---------- Interactive spellcheck ----------#
.PHONY: test-spelling-interactive
test-spelling-interactive:
	@echo
	@echo "--> Checking for spelling errors..."
	@node_modules/.bin/mdspell \
		$(testArgs) \
		--en-gb \
		--ignore-numbers \
		--ignore-acronyms \
		$(testPattern) \
		$(ignorePattern)

#---------- Linter ----------#
.PHONY: test-markdown-lint
test-markdown-lint:
	@echo
	@echo "--> Checking for messy formatting..."
	@node_modules/.bin/remark --frail $(testArgs) .

#---------- Runner ----------#
.PHONY: test
test: test-inconsiderate test-spelling test-markdown-lint
	@echo
	@echo "--- Tests passed.  See output above. ---"
