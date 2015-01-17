# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_kiala'
  s.version     = '0.1.0'
  s.summary     = 'Spree and Kiala shiping integration'
  s.description = 'Kiala shipping service working inside spree, using the flat in range calculator'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Héctor Picazo'
  s.email     = 'hector@ahaaa.es'
  s.homepage  = 'http://www.2bedigital.com'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>= 2.3.0'

  s.add_development_dependency 'capybara', '2.1'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sqlite3'
end
