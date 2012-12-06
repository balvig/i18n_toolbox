# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "i18n_toolbox/version"

Gem::Specification.new do |s|
  s.name        = "i18n_toolbox"
  s.version     = I18nToolbox::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jens Balvig"]
  s.email       = ["jens@balvig.com"]
  s.homepage    = "https://github.com/balvig/i18n_toolbox"
  s.summary     = %q{Provides a set of convenient helpers and active model additions for working with multiple languages}
  s.description = %q{Provides a set of convenient helpers and active model additions for working with multiple languages}

  s.rubyforge_project = "i18n_toolbox"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 3"
  s.add_development_dependency 'sqlite3'
end
