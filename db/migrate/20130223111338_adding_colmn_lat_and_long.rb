class AddingColmnLatAndLong < ActiveRecord::Migration
def self.up
  add_column :colleagues, :longitude, :string
  add_column :colleagues, :latitude, :string
 end

 def self.down
  remove_column :colleagues, :longitude
  remove_column :colleagues, :latitude
 end
end
