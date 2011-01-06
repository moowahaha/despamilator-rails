require 'despamilator'
require 'active_support'
require 'active_record'

module DespamilatorRails
  VERSION = "1.0"
end

module ActiveRecord

  class Base

    def validate_with_despamilator_checks
      old_spamilated_validation

      @@despamilator[:attribute_names].each do |attribute|
        text  = self.send(attribute)
        dspam = Despamilator.new(text)

        @@despamilator[:block].call(dspam) if dspam.score >= @@despamilator[:threshold]
      end
    end

    def self.validates_despamilation_of attr_names, settings, &block
      @@despamilator ||= {}

      clean_attributes = [attr_names].flatten.reject do |attribute|
        attribute.blank?
      end

      clean_attributes.empty? ? raise('At least one attribute must be defined') : @@despamilator[:attribute_names] = clean_attributes

      @@despamilator[:threshold] = settings[:threshold] || raise('A threshold score must be supplied')
      @@despamilator[:block] = block || raise('Missing block')

      alias_method_chain :validate, :despamilator_checks
      alias :old_spamilated_validation :validate      
    end

  end

end
