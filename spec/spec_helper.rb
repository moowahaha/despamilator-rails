require 'one_hundred_percent_coverage'
require File.join(File.dirname(__FILE__), '..', 'lib', 'despamilator_rails')
require 'active_record'

Dir.glob(File.join(File.dirname(__FILE__), 'test_db_migrations', '*.rb')).each do |file|
  require file
end

db_file = 'test.sqlite3'

File.unlink(db_file) if File.exists?(db_file)

ActiveRecord::Base.establish_connection(
    :adapter  => 'sqlite3',
    :database => db_file
)

CreateSomeModel.migrate(:up)

Dir.glob(File.join(File.dirname(__FILE__), 'fixtures', '*.rb')).each do |file|
  require file
end
