describe SomeActiveRecordModel do

  it_should_behave_like "a spam protected model"

  it "should notify of spam detection in a railsy way" do

    class SomeActiveRecordModelWithSpam < SomeActiveRecordModel
      validate_with_despamilator :attributes => [:some_field]
    end

    some_model            = SomeActiveRecordModelWithSpam.new
    some_model.some_field = Despamilator.gtubs_test_string

    -> {some_model.save!}.should raise_error(ActiveRecord::RecordInvalid)
    some_model.errors.full_messages.should == ["Some field looks like spam"]
  end

end
