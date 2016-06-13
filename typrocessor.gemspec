# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'typrocessor'
  s.version     = '0.0.0'
  s.authors     = ['Cédric Néhémie']
  s.email       = ['cedric.nehemie@gmail.com']
  s.homepage    = 'https://github.com/abe33/typrocessor'
  s.summary     = 'A versatile typographic cleaning processor'
  s.description = 'A versatile typographic cleaning processor that supports internationalization and customization'
  s.license     = 'MIT'

  s.files       = Dir['lib/**/*']

  s.add_development_dependency "rspec", "~> 3.3.0"
end
