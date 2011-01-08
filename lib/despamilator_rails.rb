require 'despamilator'
require 'active_support'
require 'active_record'

module DespamilatorRails
  VERSION = "1.0"
end

module ActiveRecord

  class Base

    # Rdoc this...
    #   some code example...

    def self.validate_with_despamilator settings, &block
      assign_despamilator_class_variables(block, settings)
      alias_despamilator_methods
    end

    private

    def self.alias_despamilator_methods
      alias_method :old_spamilated_validation, :validate
      alias_method_chain :validate, :despamilator_checks
    end

    def self.assign_despamilator_class_variables(block, settings)
      @@despamilator = {}

      clean_attributes = settings[:attributes].reject do |attribute|
        attribute.blank?
      end

      clean_attributes.empty? ? raise('At least one attribute must be defined') : @@despamilator[:attribute_names] = clean_attributes

      @@despamilator[:threshold] = settings[:threshold] || 1
      @@despamilator[:block]     = block || default_despamilator_detection_response
    end

    def validate_with_despamilator_checks
      old_spamilated_validation

      @@despamilator[:attribute_names].each do |attribute|
        text  = self.send(attribute)
        dspam = Despamilator.new(text)

        @@despamilator[:block].call(attribute, text, dspam) if dspam.score >= @@despamilator[:threshold]
      end
    end

    def self.default_despamilator_detection_response
      lambda { |attribute, value, dspam|
        raise "#{attribute} exceeded the spam threshold of #{@@despamilator[:threshold]} (scored: #{dspam.score}, value: #{value})"
      }
    end

  end

end
