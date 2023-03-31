# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'has_attached_tags/version'

Gem::Specification.new do |spec|
  spec.name          = 'has_attached_tags'
  spec.version       = HasAttachedTags::VERSION
  spec.authors       = ['Mihail K']
  spec.email         = ['7896757+mintyfresh@users.noreply.github.com']

  spec.summary       = 'Pluggable Tagging for ActiveRecord'
  spec.description   = 'A general purpose, typed tagging system for ActiveRecord'
  spec.homepage      = 'https://github.com/mintyfresh/has_attached_tags'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 5.1', '< 8'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'factory_bot', '~> 6.1'
  spec.add_development_dependency 'faker', '~> 2', '>= 2.13'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.88'
  spec.add_development_dependency 'rubocop-performance', '~> 1.7'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.42'
  spec.add_development_dependency 'sqlite3', '~> 1.4'
end
