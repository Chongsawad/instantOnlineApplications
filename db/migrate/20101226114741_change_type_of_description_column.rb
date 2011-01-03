class ChangeTypeOfDescriptionColumn < ActiveRecord::Migration
  def self.up
    remove_column :recipes, :description
    add_column :recipes, :description, :text
  end

  def self.down
  end
end
