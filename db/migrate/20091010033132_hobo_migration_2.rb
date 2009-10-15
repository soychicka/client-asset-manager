class HoboMigration2 < ActiveRecord::Migration
  def self.up
    create_table :task_assignments do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
      t.integer  :task_id
    end
    
    create_table :stories do |t|
      t.string   :title
      t.text     :body
      t.string   :status
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :project_id
    end
    
    create_table :projects do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    create_table :tasks do |t|
      t.string   :description
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :story_id
    end
  end

  def self.down
    drop_table :task_assignments
    drop_table :stories
    drop_table :projects
    drop_table :tasks
  end
end
