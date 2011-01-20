shared_examples_for "a spam protected model" do

  it "should check for spam on save" do
    some_instance            = described_class.new
    some_instance.some_field = Despamilator.gtubs_test_string

    some_instance.save.should be_false
  end

end