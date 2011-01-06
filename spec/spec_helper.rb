require 'one_hundred_percent_coverage'
require File.join(File.dirname(__FILE__), '..', 'lib', 'despamilator_rails')
require 'active_record'

ActiveRecord::Base.establish_connection(
        :adapter => 'sqlite3',
        :database => File.dirname(__FILE__) + '/fixtures/test.sqlite3'
)

Dir.glob(File.join(File.dirname(__FILE__), 'fixtures', '*.rb')).each do |file|
  require file
end