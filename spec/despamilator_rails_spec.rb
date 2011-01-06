describe 'despamilator validation' do

  it "should detect spam in a single field" do
    fixture           = SingleFieldTestClass.new
    fixture.text      = 'asdasd'

    fake_despamilator = mock('despamilator')
    Despamilator.should_receive(:new).and_return(fake_despamilator)
    fake_despamilator.should_receive(:score).and_return(2)

    fixture.should_receive(:result).with(fake_despamilator)
    fixture.validate
  end

  it "should ignore clean fields" do
    fixture           = SingleFieldTestClass.new
    fixture.text      = 'asdasd'

    fake_despamilator = mock('despamilator')
    Despamilator.should_receive(:new).and_return(fake_despamilator)
    fake_despamilator.should_receive(:score).and_return(0)

    fixture.should_not_receive(:result).with(fake_despamilator)

    fixture.validate
  end

  it "should detect spam in multiple fields" do
    fixture           = MultipleFieldTestClass.new

    1.upto(2) do |i|
      fixture.send("text#{i}=", 'blahblah')

      fake_despamilator = mock("despamilator#{i}")
      Despamilator.should_receive(:new).ordered.and_return(fake_despamilator)
      fake_despamilator.should_receive(:score).once.and_return(2)

      fixture.should_receive(:result).ordered.with(fake_despamilator)
    end

    fixture.validate
  end

  it "should throw an error if no threshold is supplied" do
    fixture = MissingThresholdTestClass.new
    -> {fixture.validate}.should raise_error('A threshold score must be supplied')
  end

end