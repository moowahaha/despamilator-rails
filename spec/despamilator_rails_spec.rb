describe "despamilator_rails" do

  describe "parameter checking" do

    it "should throw an exception when no threshold is supplied" do

      -> {
      class SomeModel < ActiveRecord::Base
        validates_despamilation_of [:some_field], :threshold => nil do
        end
      end
      }.should raise_error('A threshold score must be supplied')

    end

    describe "missing fields" do

      it "should throw an exception when an empty array is passed" do

        -> {
        class SomeModel < ActiveRecord::Base
          validates_despamilation_of [], :threshold => 1 do
          end
        end
        }.should raise_error('At least one attribute must be defined')

      end

      it "should throw an exception when an empty string is passed" do

        -> {
        class SomeModel < ActiveRecord::Base
          validates_despamilation_of [''], :threshold => 1 do
          end
        end
        }.should raise_error('At least one attribute must be defined')

      end

    end

    it "should throw an exception when no block is supplied" do

      -> {
      class SomeModel < ActiveRecord::Base
        validates_despamilation_of [:some_field], :threshold => 1
      end
      }.should raise_error('Missing block')

    end

  end

end
