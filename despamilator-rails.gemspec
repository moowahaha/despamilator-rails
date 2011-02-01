# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{despamilator_rails}
  s.version = "1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stephen Hardisty"]
  s.date = %q{2011-01-09}
  s.description = %q{Adds a Rails-esque validation method for use in Rails 3 with ActiveRecord or DataMapper}
  s.email = ["moowahaha@hotmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt"]
  s.files = `git ls-files`.split("\n")
  s.homepage = %q{https://github.com/moowahaha/despamilator-rails}
  s.rdoc_options = ["lib/despamilator_rails.rb", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{despamilator_rails}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Anti-spam validation hooks for Rails.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<despamilator>, [">= 1.0"])
      s.add_runtime_dependency(%q<activemodel>, [">= 3.0.0"])
    else
      s.add_dependency(%q<despamilator>, [">= 1.0"])
      s.add_dependency(%q<activemodel>, [">= 3.0.0"])
    end
  else
    s.add_dependency(%q<despamilator>, [">= 1.0"])
    s.add_dependency(%q<activemodel>, [">= 3.0.0"])
  end
end
