require 'despamilator'
require 'active_support'
require 'active_record'

module DespamilatorRails
  VERSION = "1.0"
end

module ActiveRecord

  class Base

    # Somewhere (such as your envirnoment.rb...)
    #
    #    require 'despamilator_rails'
    #
    # In your model (basic example):
    #
    #    class YourModel < ActiveRecord::Base
    #      validates_with_despamilator :attributes => [:some_field]
    #    end
    #
    # When "some_field" is assigned a spammy value, it will add to the errors. For example...
    #
    #    YourModel.new(:some_field => spammy_value).save! #=> ActiveRecord::RecordInvalid exception!
    #
    # Or...
    #
    #    your_instance = YourModel.new(:some_field => spammy_value)
    #    your_instance.save
    #    your_instance.errors.full_messages.should #=> ["Some field looks like spam"]
    #
    # If you want to configure the threshold (which defaults to 1) or add your own callback, you can do the following:
    #
    #    class YourModel < ActiveRecord::Base
    #      validates_with_despamilator :attributes => [:some_field], :threshold => 1 do |field, value, despamilator|
    #        raise "spam! field: #{field}, value: #{value}, score: #{despamailtor.score}"
    #      end
    #    end
    #
    # This example will...
    #
    #    your_instance = YourModel.new(:some_field => "spammy string")
    #    your_instance.save! #=> Exception "spam! field: some_field, value: spammy string, score: 123"
    #
    # The callback will receive the field name, the value and the instance of the Despamilator class.

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
