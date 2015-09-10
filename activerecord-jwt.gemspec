# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord-jwt/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-jwt"
  spec.version       = Activerecord::Jwt::VERSION
  spec.authors       = ["shiro16"]
  spec.email         = ["nyanyanyawan24@gmail.com"]

  spec.summary       = %q{This ActiveRecord extension adds JWT(JSON Web Token) method}
  spec.description   = %q{This ActiveRecord extension adds JWT(JSON Web Token) method}
  spec.homepage      = "https://github.com/shiro16/activerecord-jwt"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'jwt'
  spec.add_runtime_dependency 'activerecord'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3", "~> 1.0"
end
