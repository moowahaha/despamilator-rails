require 'one_hundred_percent_coverage'
require File.join(File.dirname(__FILE__), '..', 'lib', 'despamilator_rails')

Dir.glob(File.join(File.dirname(__FILE__), 'fixtures', '*.rb')).each do |file|
  require file
end