describe 'despamilator validation' do

  it "should detect spam in a single field" do
    fixture           = SingleFieldTestClass.new
    fixture.text      = 'asdasd'

    fake_despamilator = mock('despamilator')
    Despamilator.should_receive(:new).and_return(fake_despamilator)
    fake_despamilator.should_receive(:score).and_return(2)

    Kernel.should_receive(:warn).with('text (asdasd) = 2')
    fixture.validate
  end

  it "should ignore clean fields" do
    fixture           = SingleFieldTestClass.new
    fixture.text      = 'asdasd'

    fake_despamilator = mock('despamilator')
    Despamilator.should_receive(:new).and_return(fake_despamilator)
    fake_despamilator.should_receive(:score).and_return(0)

    Kernel.should_not_receive(:warn)
    fixture.validate
  end

  it "should detect spam in multiple fields" do
    fixture           = MultipleFieldTestClass.new
    fixture.text1     = 'asdasd1'
    fixture.text2     = 'asdasd2'

    fake_despamilator = mock('despamilator')
    Despamilator.should_receive(:new).twice.and_return(fake_despamilator)
    fake_despamilator.should_receive(:score).twice.and_return(2)

    Kernel.should_receive(:warn).with('text1 (asdasd1) = 2').once.ordered
    Kernel.should_receive(:warn).with('text2 (asdasd2) = 2').once.ordered

    fixture.validate
  end

  it "should throw an error if no threshold is supplied" do
    fixture = MissingThresholdTestClass.new
    -> {fixture.validate}.should raise_error('A threshold score must be supplied')
  end

end