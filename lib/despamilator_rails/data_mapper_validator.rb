module DespamilatorRails
  module DataMapperValidator

    def setup_despamilation_detection_for attribute

        validates_with_block attribute do
          text = send(attribute)
          dspam = Despamilator.new(text)
          despamilator_callback(attribute, text, dspam) if dspam.score >= despamilator_threshold
        end

    end

    def default_despamilator_detection_response
      lambda { |attribute, value, dspam|
        [false, "looks like spam"]
      }
    end

  end
end