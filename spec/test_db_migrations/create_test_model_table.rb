class CreateSomeModel < ActiveRecord::Migration
ActiveRecord::Migration.verbose = false

  def self.up

    create_table :some_models do |t|
      t.text :some_field
    end
  end

end
