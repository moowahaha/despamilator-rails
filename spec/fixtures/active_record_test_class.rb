require 'active_record'

class SomeModel < ActiveRecord::Base
  include DespamilatorRails

  def validate
    validates_despamilation_of :some_field, :threshold => 0.01 do
      raise "HOLY CRAP!"
    end
  end

end
