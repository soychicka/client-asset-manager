class HoboMigration7 < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string   :image_filename
      t.integer  :image_width
      t.integer  :image_height
      t.string   :image_name
      t.string   :image_author
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    change_column :users, :state, :string, :limit => 255, :default => "active"
  end

  def self.down
    change_column :users, :state, :string, :default => "inactive"
    
    drop_table :photos
  end
end
