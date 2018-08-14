# Discover my language
[![Build Status](https://travis-ci.org/szymon33/discover_my_language.svg?branch=master)](https://travis-ci.org/szymon33/discover_my_language)
[![Maintainability](https://api.codeclimate.com/v1/badges/fd33839164ffe84143b4/maintainability)](https://codeclimate.com/github/szymon33/discover_my_language/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/fd33839164ffe84143b4/test_coverage)](https://codeclimate.com/github/szymon33/discover_my_language/test_coverage)
 
## 1. Introduction

 This is a simple command line application, which allow users to enter an arbitrary GitHub username, and be presented with a best guess of the GitHub user's favourite programming language. This is computed by using the GitHub API to fetch all of the user's public GitHub repos, each of which includes the name of the dominant language for the repository.

## 2. Installation

`bundle install`

## 3. Running

`ruby lib/runner.rb`

## 4. Automatic tests

### Rspec
```
    bundle exec rspec
```

Note: CodeClimate badge at the top of this file proves 100% of test coverage

## 5. Screenshot

![Screentshot](https://github.com/szymon33/discover_my_language/blob/master/screenshot-1.png)

[August, 2018]
