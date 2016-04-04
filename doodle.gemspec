$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "doodle/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "doodle_rails"
  s.version     = Doodle::VERSION
  s.authors     = ["Gabriel Malaquias"]
  s.email       = ["gmalakias@bitbucket.com"]
  s.homepage    = "https://github.com/GabrielMalakias/doodle_rails"
  s.summary     = "A Rails Engine for vists based in Layer Plataform"
  s.description = "A Rails Engine for vists based in Layer Plataform"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2"

  s.add_development_dependency "sqlite3"
end
