class AddingDetailsToColleagues < ActiveRecord::Migration
  def self.up
  add_column :colleagues, :email, :string
  add_column :colleagues, :role, :string
  add_column :colleagues, :contactnum, :string
 end

 def self.down
  remove_column :colleagues, :email
  remove_column :colleagues, :role
  remove_column :colleagues, :contactnum
 end
end
