describe "active_record integration" do

  it "should check for spam on save" do
    some_instance = SomeModel.new
    some_instance.some_field = Despamilator.gtubs_test_string

    -> {some_instance.save!}.should raise_error(ActiveRecord::RecordInvalid)
  end

  it "should only support ActiveRecord 2" do
    active_record_version = ActiveRecord::VERSION::MAJOR
    ActiveRecord::VERSION.const_set(:MAJOR, 3)

    ->{
    class SomeModelOnActiveRecord2 < ActiveRecord::Base
      validate_with_despamilator :attributes => []
    end
    }.should raise_error(/This version only supports ActiveRecord 2/)

    ActiveRecord::VERSION.const_set(:MAJOR, active_record_version)
  end

end