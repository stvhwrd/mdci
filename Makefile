SHELL         := /usr/bin/env bash					# Use bash shell
sourceDir     := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/../../)
testArgs      :=									# Project-wide arguments
testPattern   := $(sourceDir)/**/*.md							# File pattern to operate on
ignorePattern := !**/node_modules/**/*.md, mdci/*	# File pattern to ignore

#---------- Sensitivity check ----------#
.PHONY: offensive-wording
offensive-wording:
	@echo
	@echo "==> Checking for inconsiderate/insensitive wording..."
	@node_modules/.bin/alex $(testArgs) --diff || true \
	$(testPattern)

#---------- Auto spellcheck ----------#
.PHONY: spellcheck-auto
spellcheck-auto:
	@$(MAKE) spellcheck-interactive \
		testArgs=--report \
		$(testPattern)

#---------- Interactive spellcheck ----------#
.PHONY: spellcheck-interactive
spellcheck-interactive:
	@echo
	@echo "==> Checking for spelling errors..."
	@node_modules/.bin/mdspell \
		$(testArgs) \
		--en-gb \
		--ignore-numbers \
		--ignore-acronyms \
		$(testPattern) \
		$(ignorePattern)

#---------- Linter ----------#
.PHONY: lint-markdown
lint-markdown:
	@echo
	@echo "==> Checking for messy formatting..."
	@node_modules/.bin/remark --frail $(testArgs) .

#---------- Local runner ----------#
.PHONY: test-pre-commit
test-pre-commit: offensive-wording spellcheck-interactive lint-markdown
	@echo
	@echo "--- Resolve any warnings or errors above before committing to version control. ---"

#---------- CI runner ----------#
.PHONY: test
test: offensive-wording spellcheck-auto lint-markdown
	@echo
	@echo "--- All fatal tests passed.  See output above for any warnings. ---"

.PHONY: submod-test
submod-test:
	@echo
	@echo $(sourceDir)