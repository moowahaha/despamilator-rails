require 'despamilator'
require 'active_model'

Dir.glob(File.join(File.dirname(__FILE__), 'despamilator_rails', '*.rb')) do |file|
  require file
end

class DespamilatorActiveRecordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, text)
    dspam = Despamilator.new(text)
    record.despamilator_callback(attribute, text, dspam) if dspam.score >= record.despamilator_threshold
  end
end

module DespamilatorRails

  # In your model (basic example):
  #
  #    class YourModel < ActiveRecord::Base
  #      validate_with_despamilator :attributes => [:some_field]
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
  # Note that, by default, DataMapper behaves slightly differently in that it will not raise exceptions
  # unless you code a callback to deal with that. Instead it will return "false" on an unsuccessful save.
  #
  # If you want to configure the threshold (which defaults to 1) or add your own callback, you can do the following:
  #
  #    class YourModel < ActiveRecord::Base
  #      validate_with_despamilator :attributes => [:some_field], :threshold => 1 do |field, value, despamilator|
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

  def validate_with_despamilator settings, & block
    extend(respond_to?(:validates_with_block) ? DespamilatorRails::DataMapperValidator : DespamilatorRails::ActiveRecordValidator)

    assign_despamilator_threshold settings
    assign_despamilator_callback block

    add_despamilator_validation settings
  end

  private

  def add_despamilator_validation settings

    clean_despamilator_attributes(settings).each do |attribute|
      setup_despamilation_detection_for attribute
    end

  end

  def clean_despamilator_attributes(settings)
    clean_attributes = settings[:attributes].reject do |attribute|
      attribute.blank?
    end

    raise('At least one attribute must be defined') if clean_attributes.empty?

    clean_attributes
  end

  def assign_despamilator_threshold(settings)
    define_method(:despamilator_threshold, lambda { settings[:threshold] || 1 })
  end

  def assign_despamilator_callback(block)
    define_method(:despamilator_callback, block || default_despamilator_detection_response)
  end

end

Module.send(:include, DespamilatorRails)
