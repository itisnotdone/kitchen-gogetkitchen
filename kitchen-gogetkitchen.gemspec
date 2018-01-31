# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kitchen/driver/gogetkitchen_version'

Gem::Specification.new do |spec|
  spec.name          = 'kitchen-gogetkitchen'
  spec.version       = Kitchen::Driver::GOGETKITCHEN_VERSION
  spec.authors       = ['Don Draper']
  spec.email         = ['donoldfashioned@gmail.com']
  spec.summary       = %q{A kitchen driver based on Gogetit.}
  spec.description   = %q{A kitchen driver based on Gogetit that has abilities to control MAAS, Libvirt and LXD.}
  spec.homepage      = 'https://github.com/itisnotdone/kitchen-gogetit'
  spec.license       = 'Apache 2.0'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = []
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'test-kitchen'
  spec.add_dependency 'gogetit'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'cane'
  spec.add_development_dependency 'tailor'
  spec.add_development_dependency 'countloc'
end
