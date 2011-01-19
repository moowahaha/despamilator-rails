require 'active_record'

class SomeActiveRecordModelBase < ActiveRecord::Base

  establish_connection :adapter => 'sqlite3', :database => 'test.sqlite3'

  connection.create_table table_name, :force => true do |t|
    t.text :some_field
  end

end
