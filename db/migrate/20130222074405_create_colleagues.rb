class CreateColleagues < ActiveRecord::Migration
  def change
    create_table :colleagues do |t|
      t.string :name
      t.string :location
      t.string :project

      t.timestamps
    end
  end
end
