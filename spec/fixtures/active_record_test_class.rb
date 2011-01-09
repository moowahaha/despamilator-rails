class SomeModel < ActiveRecord::Base

  validates_with DespamilatorRails, :attributes => [:some_field]

end
