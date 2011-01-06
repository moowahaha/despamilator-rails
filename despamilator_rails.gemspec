# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{despamilator_rails}
  s.version = "1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stephen Hardisty"]
  s.date = %q{2010-12-11}
  s.description = %q{FIX (describe your package)}
  s.email = ["moowahaha@hotmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt"]
  s.files = [".rspec", ".rvmrc", "Gemfile", "Gemfile.lock", "History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "despamilator_rails.gemspec", "lib/despamilator_rails.rb", "spec/despamilator_rails_spec.rb", "spec/spec_helper.rb", "vendor/cache/RedCloth-4.2.3.gem", "vendor/cache/activesupport-2.3.10.gem", "vendor/cache/despamilator-1.0.gem", "vendor/cache/diff-lcs-1.1.2.gem", "vendor/cache/hoe-2.8.0.gem", "vendor/cache/newgem-1.5.3.gem", "vendor/cache/one_hundred_percent_coverage-0.0.2.gem", "vendor/cache/rake-0.8.7.gem", "vendor/cache/rspec-2.2.0.gem", "vendor/cache/rspec-core-2.2.1.gem", "vendor/cache/rspec-expectations-2.2.0.gem", "vendor/cache/rspec-mocks-2.2.0.gem", "vendor/cache/rubigen-1.5.5.gem", "vendor/cache/simplecov-0.3.7.gem", "vendor/cache/simplecov-html-0.3.9.gem", "vendor/cache/syntax-1.0.0.gem"]
  s.homepage = %q{http://github.com/#{github_username}/#{project_name}}
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
      s.add_development_dependency(%q<hoe>, [">= 2.8.0"])
    else
      s.add_dependency(%q<despamilator>, [">= 1.0"])
      s.add_dependency(%q<hoe>, [">= 2.8.0"])
    end
  else
    s.add_dependency(%q<despamilator>, [">= 1.0"])
    s.add_dependency(%q<hoe>, [">= 2.8.0"])
  end
end