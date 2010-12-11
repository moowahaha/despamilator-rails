require 'despamilator'
require 'ostruct'

module DespamilatorRails
  VERSION = "1.0"

  def validates_despamilation_of(attr_names, settings)
    threshold = settings[:threshold] || raise('A threshold score must be supplied')
    
    [attr_names].flatten.each do |attribute|
      text  = self.send(attribute)
      score = Despamilator.new(text).score

      yield(OpenStruct.new({
                               :field     => attribute,
                               :text      => text,
                               :score     => score,
                               :threshold => threshold
      })) if score >= threshold
    end
  end
end
  