require 'despamilator'

module DespamilatorRails
  VERSION = "1.0"

  def validates_despamilation_of(* attr_names)
    threshold = attr_names.pop[:threshold] || raise('A threshold score must be supplied')

    attr_names.each do |attribute|
      self.errors.add(attribute, "has exceeded the spam threshold of #{threshold}") if Despamilator.new(self.send(attribute)).score >= threshold
    end
  end
end
  