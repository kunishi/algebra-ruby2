# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'algebra/version'

Gem::Specification.new do |spec|
  spec.name          = "algebra"
  spec.version       = Algebra::VERSION
  spec.authors       = ["Takeo Kunishima"]
  spec.email         = ["t.kunishi@gmail.com"]

  spec.summary       = %q{a library for mathematical computations.}
  spec.description   = %q{This is a library for mathematical computations. Our purpose is to express the mathematical object naturally in Ruby. Though it is not operated fast, we can see the algorithm of the mathematical processing not in black box but in scripts.  This library is in development stage.}
  spec.homepage      = "https://github.com/kunishi/algebra-ruby2"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.2.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.required_ruby_version = '>= 1.9.3'
end
