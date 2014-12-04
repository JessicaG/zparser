# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zparser/version'

Gem::Specification.new do |spec|
  spec.name          = "zparser"
  spec.version       = Zparser::VERSION
  spec.authors       = ["Jessica Goulding"]
  spec.email         = ["jgoulding2@gmail.com"]
  spec.summary       = %q{Scraping and parsing data}
  spec.description   = %q{on the list of things to do}
  spec.homepage      = "http://findmynewhome.co"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_development_dependency 'rspec', '~> 2.12'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
