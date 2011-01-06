class SingleFieldTestClass
  include DespamilatorRails

  attr_accessor :text

  def validate
    validates_despamilation_of :text, :threshold => 1 do |dspam|
      result dspam
    end
  end
end
