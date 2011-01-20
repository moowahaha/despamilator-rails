require 'dm-migrations'
require 'dm-validations'

class SomeDataMapperModel

  DataMapper.setup(:default, 'sqlite::memory:')

  include DataMapper::Resource

  property :id, Serial
  property :some_field, Text

  validate_with_despamilator :attributes => [:some_field]

end

DataMapper.auto_migrate!