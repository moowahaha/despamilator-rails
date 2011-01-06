class MultipleFieldTestClass
  include DespamilatorRails

  attr_accessor :text1, :text2

  def validate
    validates_despamilation_of [:text1, :text2], :threshold => 1 do |dspam|
      result dspam
    end
  end
end
