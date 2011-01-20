describe SomeDataMapperModel do

  it_should_behave_like "a spam protected model"

  it "should notify of spam detection in a railsy way" do

    class SomeDataMapperModelWithSpam < SomeDataMapperModel
      validate_with_despamilator :attributes => [:some_field]
    end

    some_model            = SomeDataMapperModelWithSpam.new
    some_model.some_field = Despamilator.gtubs_test_string

    some_model.save.should be_false
    some_model.errors.first.should == ["looks like spam"]
  end
end