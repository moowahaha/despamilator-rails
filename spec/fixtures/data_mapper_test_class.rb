require 'dm-migrations'
require 'dm-validations'

class SomeDataMapperModel

  DataMapper.setup(:default, 'sqlite::memory:')

  include DataMapper::Resource

  property :id, Serial
  property :some_field, Text

end

DataMapper.auto_migrate!