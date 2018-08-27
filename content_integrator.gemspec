
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "content_integrator/version"

Gem::Specification.new do |spec|
  spec.name          = "content_integrator"
  spec.version       = ContentIntegrator::VERSION
  spec.authors       = ["Lucas Teles"]
  spec.email         = ["lucasteles22@gmail.com"]

  spec.summary       = "Rock Content library to do external integrations"
  spec.description   = "Facebook, LinkedIn, Twitter, Google, Medium and Wordpres integrations"
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
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

  # Social Integrations
  spec.add_dependency "koala", "~> 3.0"
  spec.add_dependency "twitter", "~> 6.1.0"
  spec.add_dependency "linkedin-oauth2", "~> 1.0"

  # Google Analytics integration
  spec.add_dependency "legato", "~> 0.7.0"

  spec.add_dependency "oauth2", "~> 1.0"

  spec.add_dependency "rest-client", "~> 2.0", ">= 2.0.2"

  spec.add_dependency "rack-timeout", "~> 0.5.1"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
