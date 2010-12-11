class MissingThresholdTestClass
  include DespamilatorRails

  attr_accessor :text

  def validate
    validates_despamilation_of :text, :threshold => nil do |result|
    end
  end
end
