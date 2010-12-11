class SingleFieldTestClass
  include DespamilatorRails

  attr_accessor :text

  def validate
    validates_despamilation_of :text, :threshold => 1 do |result|
      Kernel.warn "#{result.field} (#{result.text}) = #{result.score}"
    end
  end
end
