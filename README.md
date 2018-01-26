# mdci [![Build Status](https://travis-ci.org/stvhwrd/mdci.svg?branch=master)](https://travis-ci.org/stvhwrd/mdci)

### Continuous integration for Markdown files.

> Note: This project has not been tested extensively, and may give false positives and/or false negatives if advanced Markdown (like [MultiMarkdown](https://github.com/fletcher/MultiMarkdown-6)) is used.

## Dependencies

* [CMake](https://cmake.org/)
* [NPM](https://www.npmjs.com/):
    - [alex](https://www.npmjs.com/package/alex) to detect insensitive, inconsiderate writing;
    - [markdown-spellcheck](https://www.npmjs.com/package/markdown-spellcheck) for spellcheck, using open source Hunspell dictionary files;
    - [remark-cli](https://www.npmjs.com/package/remark-cli) for linting.
* [Travis CI](https://travis-ci.org)

Here's a one-liner to verify that you have the dependencies installed:
```shell
if type "npm" &> /dev/null && type "maker" &> /dev/null; then echo "\nGOOD TO GO!"; else echo "\nDependencies not installed."; fi
```

## Installation

1. Clone the project:
    `git clone https://github.com/stvhwrd/mdci.git`
    
2. Change directory:
    `cd mdci`
    
3. Install NPM packages:
    `npm install`
    
4. Run tests on `.md` files in the current directory, by running any of the [commands](#commands) below.

## Commands

### Sensitivity check:

* `make offensive-wording`

Check for words and phrases from a list of [common inequalities and exclusivities](https://github.com/retextjs/retext-equality/blob/master/rules.md) and, separately, a list of [profanities](https://github.com/retextjs/retext-profanities/blob/master/rules.md) (NSFW).

### Interactive spellcheck:

Check spelling and ask user how to handle each perceived spelling error, allowing the user to interactively build their dictionary (`.spelling`) file on a per-word basis.

* `make spellcheck-interactive`

### Auto spellcheck:

Check spelling and fail on any perceived spelling error that is not in the custom dictionary (`.spelling`).

* `make spellcheck-auto`

### Linter:

Check syntax and structure of Markdown, fail on any errors.

* `make lint-markdown`

### Local runner:

Run [sensitivity check](#sensitivity-check) and [linter](#linter) as normal, but run [spellcheck](#interactive-spellcheck) interactively.  This test sequence is suitable to run before committing Markdown files to version control.

* `make test-pre-commit`

### Continuous integration runner:

Run all tests in headless (non-interactive) mode.

* `make test`

## TODO
See [GitHub Issues](https://github.com/stvhwrd/mdci/issues).

## Credits

Big thanks to [@kvz](https://github.com/kvz) for their [blog post](https://kvz.io/blog/2015/09/16/watch-your-language/) which is the basis of - and inspiration for - this project.
