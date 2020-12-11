# frozen_string_literal: true

require_relative 'lib/miniflow/version'

Gem::Specification.new do |spec|
  spec.name          = 'miniflow'
  spec.version       = Miniflow::VERSION
  spec.authors       = ['kojix2']
  spec.email         = ['2xijok@gmail.com']

  spec.summary       = 'A very small tool to help you execute workflows'
  spec.description   = 'A very small tool to help you execute workflows'
  spec.homepage      = 'https://github.com/kojix2/miniflow'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.files         = Dir['*.{md,txt}', '{lib}/**/*']
  spec.require_paths = ['lib']

  spec.add_dependency 'tty-box'
  spec.add_dependency 'tty-command'
  spec.add_dependency 'tty-screen'
  spec.add_dependency 'tty-tree'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'yard'
end
