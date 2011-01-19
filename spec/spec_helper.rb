require 'one_hundred_percent_coverage'

require File.join(File.dirname(__FILE__), '..', 'lib', 'despamilator_rails')

%w{active_record_test_class_base active_record_test_class data_mapper_test_class}.each do |file|
  require File.join(File.dirname(__FILE__), 'fixtures', file)
end
