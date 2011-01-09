require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/despamilator_rails'

Hoe.plugin :newgem

$hoe = Hoe.spec 'despamilator_rails2' do
  self.developer 'Stephen Hardisty', 'moowahaha@hotmail.com'
  self.rubyforge_name       = self.name
  self.extra_deps         = [['despamilator','>= 1.0'], ['activerecord', '>= 2.3.2']]
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }

task :default => [:spec]
task :test => [:spec]

desc "Generate appropriate rdoc"
task :rdoc do
  sh "rdoc README.rdoc lib/despamilator_rails.rb"
end

task :cultivate do
  sh "rm -f *.sqlite3"
  sh "touch Manifest.txt; rake check_manifest |grep -v \"(in \" | patch"
  sh "rake debug_gem | grep -v \"(in \" > `basename \\`pwd\\``.gemspec"
end
