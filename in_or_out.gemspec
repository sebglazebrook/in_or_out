# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'in_or_out/version'

Gem::Specification.new do |spec|
  spec.name          = 'in_or_out'
  spec.version       = InOrOut::VERSION
  spec.authors       = ['Sebastian Glazebrook']
  spec.email         = ['me@sebglazebrook.com']
  spec.description   = %q{This gem will help you check whether you AFL fantasy football players are playing this week or not}
  spec.summary       = %q{Hopefully this can help you with your AFL fantasy football. It's an easy gem. Let me know if you find any issues.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'afl_schedule' , '~> 0.1.1'
  spec.add_dependency 'active_support'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'mechanize'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', '2.13.0'
  spec.add_development_dependency 'rspec-radar'
end

