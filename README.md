# ssh2http

A restricted login shell for Git-only SSH access,
which delegates git pull/push requests to a git http backend.

[![Gem Version](https://badge.fury.io/rb/ssh2http.svg)](https://badge.fury.io/rb/ssh2http)
[![Build Status](https://travis-ci.org/pmq20/ssh2http.svg)](https://travis-ci.org/pmq20/ssh2http)
[![Code Climate](https://codeclimate.com/github/pmq20/ssh2http/badges/gpa.svg)](https://codeclimate.com/github/pmq20/ssh2http)
[![codecov.io](https://codecov.io/github/pmq20/ssh2http/coverage.svg?branch=master)](https://codecov.io/github/pmq20/ssh2http?branch=master)
[![](http://inch-ci.org/github/pmq20/ssh2http.svg?branch=master)](http://inch-ci.org/github/pmq20/ssh2http?branch=master)


## installation

    gem install ssh2http

## usage

    chsh -s $(command -v ssh2http) <user>
    git clone <user>@localhost:/path/to/repo.git
    ssh <user>@localhost

hint: you may need to add ssh2http to your `/etc/shells` first.
