ActiveRecord::Base.establish_connection(
        :adapter => 'sqlite3',
        :database => File.dirname(__FILE__) + '/fixtures/test.sqlite3'
)

describe "activerecord integration" do
  it "should check for spam on save" do
    some_instance = SomeModel.new

    some_instance.some_field = 'sdfljkh1aqqqaddf1aqqq3q3242342342jaaqq <a href="blah">moo</a>'

    -> {some_instance.save}.should raise_error("HOLY CRAP!")
  end
end