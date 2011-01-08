# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{despamilator_rails}
  s.version = "1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stephen Hardisty"]
  s.date = %q{2011-01-08}
  s.description = %q{FIX (describe your package)}
  s.email = ["moowahaha@hotmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt"]
  s.files = [".rspec", ".rvmrc", "Gemfile", "Gemfile.lock", "History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "despamilator-rails.gemspec", "lib/despamilator_rails.rb", "spec/active_record_integration_spec.rb", "spec/despamilator_rails_spec.rb", "spec/fixtures/active_record_test_class.rb", "spec/fixtures/test.sqlite3", "spec/spec_helper.rb"]
  s.homepage = %q{https://github.com/moowahaha/despamilator-rails}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{despamilator_rails}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{FIX (describe your package)}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<despamilator>, [">= 1.0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.2"])
      s.add_development_dependency(%q<hoe>, [">= 2.8.0"])
    else
      s.add_dependency(%q<despamilator>, [">= 1.0"])
      s.add_dependency(%q<activesupport>, [">= 2.3.2"])
      s.add_dependency(%q<hoe>, [">= 2.8.0"])
    end
  else
    s.add_dependency(%q<despamilator>, [">= 1.0"])
    s.add_dependency(%q<activesupport>, [">= 2.3.2"])
    s.add_dependency(%q<hoe>, [">= 2.8.0"])
  end
end
