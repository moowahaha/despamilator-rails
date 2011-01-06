describe "active_record integration" do
  it "should check for spam on save" do
    some_instance = SomeModel.new

    some_instance.some_field = 'sdfljkh1aqqqaddf1aqqq3q3242342342jaaqq <a href="blah">moo</a>'

    -> {some_instance.save}.should raise_error("HOLY CRAP!")
  end
end