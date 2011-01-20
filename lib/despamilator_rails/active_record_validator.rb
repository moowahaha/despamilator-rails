module DespamilatorRails
  module ActiveRecordValidator

    def setup_despamilation_detection_for attribute
      validates attribute, :despamilator_active_record => true
    end

    def default_despamilator_detection_response
      lambda { |attribute, value, dspam|
        errors.add(attribute, "looks like spam")
      }
    end

  end
end