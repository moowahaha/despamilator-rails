require 'dm-migrations'

class SomeDataMapperModel

  DataMapper.setup(:default, 'sqlite::memory:')

  include DataMapper::Resource
  include ActiveModel::Validations

  property :id, Serial
  property :some_field, String

  validate_with_despamilator :attributes => [:some_field]

end

DataMapper.auto_migrate!