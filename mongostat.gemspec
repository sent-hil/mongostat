# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongostat/version'

Gem::Specification.new do |spec|
  spec.name          = "mongostat"
  spec.version       = Mongostat::VERSION
  spec.authors       = ["Senthil"]
  spec.email         = ["senthil@koding.com"]
  spec.description   = %q{Ruby wrapper around mongostat}
  spec.summary       = %q{Ruby wrapper around mongostat}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry"
end
