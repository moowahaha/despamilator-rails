require 'rubygems'
require 'fileutils'
require './lib/despamilator_rails'

task :default => [:test]

desc "Run specs"
task :test do
  sh "rspec spec"
end

desc "Generate appropriate rdoc"
task :rdoc do
  sh "rdoc README.rdoc lib/despamilator_rails.rb"
end

task :cultivate do
  sh "rm -f *.sqlite3"
  sh "touch Manifest.txt; rake check_manifest |grep -v \"(in \" | patch"
  sh "rake debug_gem | grep -v \"(in \" > `basename \\`pwd\\``.gemspec"
end

desc "Build the gem"
task :package do
  sh "gem build despamilator-rails.gemspec"
end