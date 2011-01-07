require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/despamilator_rails'

Hoe.plugin :newgem

$hoe = Hoe.spec 'despamilator_rails' do
  self.developer 'Stephen Hardisty', 'moowahaha@hotmail.com'
  self.rubyforge_name       = self.name
  self.extra_deps         = [['despamilator','>= 1.0'], ['activesupport', '>= 2.3.2']]
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }

task :default => [:spec]
task :test => [:spec]

task :cultivate do
  sh "touch Manifest.txt; rake check_manifest |grep -v \"(in \" | patch"
  sh "cat Manifest.txt  | grep -v 'bundle/config' | grep -v '_corpus' > Manifest.txt2"
  sh "mv Manifest.txt2 Manifest.txt"
  sh "rake debug_gem | grep -v \"(in \" > `basename \\`pwd\\``.gemspec"
end
