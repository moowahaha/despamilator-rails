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
      assign_despamilator_attributes settings
      assign_despamilator_threshold settings
      assign_despamilator_callback block

      alias_despamilator_methods
    end

    private

    class << self

      def alias_despamilator_methods
        alias_method :old_spamilated_validation, :validate
        alias_method_chain :validate, :despamilator_checks
      end

      def assign_despamilator_attributes(settings)
        clean_attributes = settings[:attributes].reject do |attribute|
          attribute.blank?
        end

        clean_attributes.empty? ? raise('At least one attribute must be defined') : define_method('despamilator.attributes', lambda { clean_attributes })
      end

      def assign_despamilator_threshold(settings)
        define_method('despamilator.threshold', lambda { settings[:threshold] || 1 })
      end

      def assign_despamilator_callback(block)
        define_method('despamilator.callback', block || default_despamilator_detection_response)
      end

    end

    def validate_with_despamilator_checks
      old_spamilated_validation

      threshold = send('despamilator.threshold')

      send('despamilator.attributes').each do |attribute|
        text  = self.send(attribute)
        dspam = Despamilator.new(text)

        send('despamilator.callback', attribute, text, dspam) if dspam.score >= threshold
      end
    end

    def self.default_despamilator_detection_response
      lambda { |attribute, value, dspam|
        raise "#{attribute} exceeded the spam threshold of #{send('despamilator.threshold')} (scored: #{dspam.score}, value: #{value})"
      }
    end

  end

end
