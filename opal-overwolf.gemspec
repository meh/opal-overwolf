Gem::Specification.new {|s|
  s.name     = 'opal-overwolf'
  s.version  = '0.1.0'
  s.author   = 'meh.'
  s.email    = 'meh@schizofreni.co'
  s.homepage = 'http://github.com/opal/opal-overwolf'
  s.platform = Gem::Platform::RUBY
  s.summary  = 'Overwolf support for Opal.'
  s.license  = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'opal-browser'
}
