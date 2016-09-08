# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'codelocks/version'

Gem::Specification.new do |spec|
  spec.name          = "codelocks"
  spec.version       = Codelocks::VERSION
  spec.authors       = ["Robert May"]
  spec.email         = ["robert@kanso.io"]
  spec.summary       = %q{A simple API wrapper for the CodeLocks API}
  spec.description   = %q{A wrapper for the CodeLocks NetCode API used to generate lock codes.}
  spec.homepage      = "http://www.codelocks.co.uk"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "vcr", "~> 2.9"
  spec.add_development_dependency "dotenv", "~> 2.0"
  spec.add_development_dependency "pry"

  spec.add_dependency "faraday", "~> 0.9"

  spec.required_ruby_version = "~> 2.2"
end
