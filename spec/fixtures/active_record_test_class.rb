class SomeModel < ActiveRecord::Base

  validate_with_despamilator :attributes => [:some_field]

end
