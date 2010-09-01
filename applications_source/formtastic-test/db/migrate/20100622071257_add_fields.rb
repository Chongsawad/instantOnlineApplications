class AddFields < ActiveRecord::Migration
  def self.up
    add_column :posts, :title1, :string
    add_column :posts, :title2, :string
    add_column :posts, :title3, :string
    add_column :posts, :title4, :string
    add_column :posts, :title5, :string
    add_column :posts, :title6, :string
  end

  def self.down
  end
end
