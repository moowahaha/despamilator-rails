class SomeModel < ActiveRecord::Base
  
  validates_despamilation_of [:some_field], :threshold => 0.01 do
    raise "HOLY CRAP!"
  end

end
