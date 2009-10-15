class HoboMigration3 < ActiveRecord::Migration
  def self.up
    create_table :story_statuses do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    add_column :stories, :status_id, :integer
    remove_column :stories, :status
    
    statuses = %w(new accepted discussion implementation user_testing deployed rejected)
    statuses.each { |status| StoryStatus.create :name => status }
    change_column :users, :state, :string, :limit => 255, :default => "inactive"
  end

  def self.down
    remove_column :stories, :status_id
    add_column :stories, :status, :string
    
    change_column :users, :state, :string, :default => "active"
    
    drop_table :story_statuses
  end
end
