class AddingAttachment < ActiveRecord::Migration
def self.up
  add_column :colleagues, :attachment_file_name, :string
  add_column :colleagues, :attachment_content_type, :string
  add_column :colleagues, :attachment_file_size, :integer
  add_column :colleagues, :attachment_updated_at, :datetime
 end

 def self.down
  remove_column :colleagues, :attachment_file_size
  remove_column :colleagues, :attachment_content_type
  remove_column :colleagues, :attachment_file_name
  remove_column :colleagues, :attachment_updated_at
 end
end
