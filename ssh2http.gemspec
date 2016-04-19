# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ssh2http/version'

Gem::Specification.new do |spec|
  spec.name          = "ssh2http"
  spec.version       = Ssh2http::VERSION
  spec.authors       = ["P.S.V.R"]
  spec.email         = ["pmq2001@gmail.com"]

  spec.summary       = %q{delegating git ssh requests to git http backends}
  spec.description   = %q{A restricted login shell for Git-only SSH access, which delegates git pull/push requests to a git http backend.}
  spec.homepage      = 'https://github.com/pmq20/ssh2http'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
