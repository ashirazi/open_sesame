# -*- encoding: utf-8 -*-
require File.expand_path('../lib/open_sesame/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Arild Shirazi"]
  gem.email         = ["ashirazi@xevious.local"]
  gem.description   = %q{A simple DSL for adding permissions to Ruby programs}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "open_sesame"
  gem.require_paths = ["lib"]
  gem.version       = OpenSesame::VERSION
end
