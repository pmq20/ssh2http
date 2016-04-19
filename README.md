# ssh2http

A restricted login shell for Git-only SSH access,
which delegates git pull/push requests to a git http backend.

[![Gem Version](https://badge.fury.io/rb/ssh2http.svg)](https://badge.fury.io/rb/ssh2http)
[![Build Status](https://travis-ci.org/pmq20/ssh2http.svg)](https://travis-ci.org/pmq20/ssh2http)
[![Code Climate](https://codeclimate.com/github/pmq20/ssh2http/badges/gpa.svg)](https://codeclimate.com/github/pmq20/ssh2http)
[![codecov.io](https://codecov.io/github/pmq20/ssh2http/coverage.svg?branch=master)](https://codecov.io/github/pmq20/ssh2http?branch=master)
[![](http://inch-ci.org/github/pmq20/ssh2http.svg?branch=master)](http://inch-ci.org/github/pmq20/ssh2http?branch=master)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ssh2http'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ssh2http

## Usage

Add this line to your ~<user>/.ssh/authorized_keys:

    command="source $HOME/.profile && cd <your_project_path> && bundle exec ssh2http <HTTP destination>",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty <your_pub_key>

Or if you prefer to install the gem globally:

    command="source $HOME/.profile && ssh2http <HTTP destination>",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty <your_pub_key>

For example,

    command="source $HOME/.profile && cd /Users/pmq20/ssh2http && bundle exec ssh2http http://localhost",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa XXXXXXXXXXXXXXXXXXXX pmq2001@gmail.com

Then:

    git clone pmq20@localhost:/path/to/repo.git

and the request will be delegated to `http://localhost/path/to/repo.git`.
