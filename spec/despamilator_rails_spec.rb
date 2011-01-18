describe "despamilator_rails" do

  it "should notify of spam detection in a railsy way" do

    class SomeModelWithSpam < SomeModelBase
      validate_with_despamilator :attributes => [:some_field]
    end

    some_model            = SomeModelWithSpam.new
    some_model.some_field = Despamilator.gtubs_test_string

    -> {some_model.save!}.should raise_error(ActiveRecord::RecordInvalid)
    some_model.errors.full_messages.should == ["Some field looks like spam"]
  end

  describe "threshold" do

    it "should default to 1" do

      class SomeModelWithDefaultThreshold < SomeModelBase
        validate_with_despamilator :attributes => [:some_field]
      end

      some_model            = SomeModelWithDefaultThreshold.new
      some_model.despamilator_threshold.should == 1
    end

    it "should be settable" do

      class SomeModelWithDefinedThreshold < SomeModelBase
        validate_with_despamilator :attributes => [:some_field], :threshold => 9
      end

      some_model            = SomeModelWithDefinedThreshold.new
      some_model.despamilator_threshold.should == 9

    end

  end

  describe "attributes" do

    it "should cause an exception when an empty array is passed" do

      ->{
      class SomeModelWithMissingAttributes < SomeModelBase
        validate_with_despamilator :attributes => []
      end
      }.should raise_error('At least one attribute must be defined')

    end

    it "should cause an exception when an empty string is passed" do

      -> {
      class SomeModelWithEmptyAttributes < SomeModelBase
        validate_with_despamilator :attributes => ['']
      end
      }.should raise_error('At least one attribute must be defined')

    end

  end

  it "should allow a block to be specified" do

    class SomeModelWithABlock < SomeModelBase
      def do_something field, value, despamilator
      end

      validate_with_despamilator :attributes => [:some_field] do |field, value, despamilator|
        do_something(field, value, despamilator)
      end
    end

    fake_despamilator = mock('despamilator')
    Despamilator.should_receive(:new).and_return(fake_despamilator)
    fake_despamilator.should_receive(:score).and_return(10000)

    some_model = SomeModelWithABlock.new
    some_model.should_receive(:do_something).with(:some_field, 'blah', fake_despamilator)
    some_model.some_field = 'blah'
    some_model.save

  end

end
