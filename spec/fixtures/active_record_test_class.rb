class SomeModel < ActiveRecord::Base

  establish_connection :adapter => 'sqlite3', :database => 'test.sqlite3'

  connection.create_table table_name, :force => true do |t|
    t.text :some_field
  end

  validate_with_despamilator :attributes => [:some_field]
end
