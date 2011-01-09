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

      add_despamilator_validation settings
    end

    private

    class << self

      def add_despamilator_validation settings

        send(validation_method(:save), settings) do |record|

          record.despamilator_checked_attributes.each do |attribute|
            text  = record.send(attribute)
            dspam = Despamilator.new(text)

            record.despamilator_callback(attribute, text, dspam) if dspam.score >= record.despamilator_threshold
          end

        end

      end

      def assign_despamilator_attributes(settings)
        clean_attributes = settings[:attributes].reject do |attribute|
          attribute.blank?
        end

        raise('At least one attribute must be defined') if clean_attributes.empty?

        define_method(:despamilator_checked_attributes, lambda { clean_attributes })
      end

      def assign_despamilator_threshold(settings)
        define_method(:despamilator_threshold, lambda { settings[:threshold] || 1 })
      end

      def assign_despamilator_callback(block)
        define_method(:despamilator_callback, block || default_despamilator_detection_response)
      end

      def default_despamilator_detection_response
        lambda { |attribute, value, dspam|
          errors.add(attribute, "looks like spam")
        }
      end

    end

  end

end
