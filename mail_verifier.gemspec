# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mail_verifier/version'

Gem::Specification.new do |spec|
  spec.name          = "mail_verifier"
  spec.version       = MailVerifier::VERSION
  spec.authors       = ["Feña Agar"]
  spec.email         = ["fernando.agar@gmail.com"]

  spec.summary       = %q{Small gem to verify emails.}
  spec.description   = %q{Small gem to verify emails without sending one.}
  spec.homepage      = "https://github.com/elfenars/mail_verifier"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug"
end
