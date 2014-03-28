# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'DriveClient/version'

Gem::Specification.new do |spec|
  spec.name          = "DriveClient"
  spec.version       = DriveClient::VERSION
  spec.authors       = ["Pascal Gläser"]
  spec.email         = ["pasi1995@gmail.com"]
  spec.summary       = %q{Interact with Google Drive API.}
  spec.description   = %q{This Gem allows you to interact with the Google Drive API.}
  spec.homepage      = "http://driveclient.ph3nx.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.1.1"
  spec.add_development_dependency "rspec", "~> 2.14.1"

  spec.add_dependency 'curb', '~> 0.8.5'
  spec.add_dependency 'json', '~> 1.8.1'
end
