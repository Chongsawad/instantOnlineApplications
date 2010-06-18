class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.text :content
      t.string :img_path
      t.string :path

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
