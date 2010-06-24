class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string   "name",            :null => false
      t.integer  "project_id",      :null => false
      t.integer  "user_id",         :null => false
      t.string   "path",            :null => false
      t.string   "payment"
      t.string   "status"
      t.string   "description"

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
