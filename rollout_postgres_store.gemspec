# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rollout_postgres_store/version'

Gem::Specification.new do |spec|
  spec.name          = "rollout_postgres_store"
  spec.version       = RolloutPostgresStore::VERSION
  spec.authors       = ["phereford"]
  spec.email         = ["patrick.hereford@americastestkitchen.com"]
  spec.summary       = %q{Simple Postgres Hstore wrapper for Rollout gem.}
  spec.description   = %q{Simple Postgres Hstore wrapper for Rollout gem.}
  spec.homepage      = "http://github.com/Americastestkitchen/rollout_postgres_store"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 4.0.0"
  spec.add_dependency "pg", ">= 0.15.1"
  spec.add_dependency "rollout", ">= 2.0.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2.0"
  spec.add_development_dependency "database_cleaner", "~> 1.4.0"
end
