class AddDetailToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :detail, :string
    add_column :projects, :url_project, :string
    add_column :projects, :url_demo, :string

  end

  def self.down
    remove_column :projects, :detail, :string
    remove_column :projects, :url_project, :string
    remove_column :projects, :url_demo, :string
  end
end
