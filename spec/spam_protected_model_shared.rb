shared_examples_for "a spam protected model" do

  before do
    Object.send(:remove_const, :TestClass) if Module.constants.include?(:TestClass)
  end

  it "should be just fine when no spam is passed" do
    some_instance            = described_class.new
    some_instance.some_field = 'hello'

    some_instance.save.should be_true
  end

  it "should check for spam on save" do

    class TestClass < described_class
      validate_with_despamilator :attributes => [:some_field]
    end

    some_instance            = TestClass.new
    some_instance.some_field = Despamilator.gtubs_test_string

    some_instance.save.should be_false
  end

  describe "threshold" do

    it "should default to 1" do

      class TestClass < described_class
        validate_with_despamilator :attributes => [:some_field]
      end

      some_model = TestClass.new
      some_model.despamilator_threshold.should == 1
    end

    it "should be settable" do

      class TestClass < described_class
        validate_with_despamilator :attributes => [:some_field], :threshold => 9
      end

      some_model = TestClass.new
      some_model.despamilator_threshold.should == 9

    end

  end

  describe "attributes" do

    it "should cause an exception when an empty array is passed" do

      ->{
      class TestClass < described_class
        validate_with_despamilator :attributes => []
      end
      }.should raise_error('At least one attribute must be defined')

    end

    it "should cause an exception when an empty string is passed" do

      -> {
      class TestClass < described_class
        validate_with_despamilator :attributes => ['']
      end
      }.should raise_error('At least one attribute must be defined')

    end

  end

  it "should allow a block to be specified" do

    class TestClass < described_class
      def do_something field, value, despamilator
      end

      validate_with_despamilator :attributes => [:some_field] do |field, value, despamilator|
        do_something(field, value, despamilator)
      end
    end

    fake_despamilator = mock('despamilator')
    Despamilator.should_receive(:new).and_return(fake_despamilator)
    fake_despamilator.should_receive(:score).and_return(10000)

    some_model = TestClass.new
    some_model.should_receive(:do_something).with(:some_field, 'blah', fake_despamilator)
    some_model.some_field = 'blah'
    some_model.save

  end

end