describe "data mapper integration" do
  # todo refactor to shared spec
  it "should check for spam on save" do
    some_instance            = SomeDataMapperModel.new
    some_instance.some_field = Despamilator.gtubs_test_string

    -> { some_instance.save! }.should raise_error(ActiveRecord::RecordInvalid)
  end
end