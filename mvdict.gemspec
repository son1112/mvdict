lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mvdict/version"

Gem::Specification.new do |spec|
  spec.name = "mvdict"
  spec.version = MvDict::VERSION
  spec.authors = ["son1112"]
  spec.email = ["anderson.reinkordt@gmail.com"]

  spec.summary = %q{Multivalue Dictionary sample ruby cli}
  spec.description = %q{For fun, get deep into basics!}
  spec.homepage = "https://github.com/son1112/mvdict"
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'tty-prompt'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 12.3', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'pronto'
  spec.add_development_dependency 'pronto-rubocop'
  spec.add_development_dependency 'pronto-reek'
end
