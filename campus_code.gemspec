# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'campus_code/version'

Gem::Specification.new do |spec|
  spec.name          = "campus_code"
  spec.version       = CampusCode::VERSION
  spec.authors       = ["matthew238"]
  spec.email         = ["matthew.szulik@gmail.com"]

  spec.summary       = %q{Campus Code Generator}
  spec.description   = %q{This gem command generates campus codes from its region and coordinates.}
  spec.homepage      = "https://github.com/kosen-robocon-db/campus_code"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "geocoder", "~> 1.4.1"
  spec.add_dependency "thor", "~> 0.19.4"
end
