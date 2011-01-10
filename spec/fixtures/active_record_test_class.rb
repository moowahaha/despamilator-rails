class SomeModel < ActiveRecord::Base

  #validates_with DespamilatorRails, :attributes => [:some_field]

  validate_with_despamilator :attributes => [:some_field]
end
