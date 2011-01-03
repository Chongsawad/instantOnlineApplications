class CreateDeployments < ActiveRecord::Migration
  def self.up
    create_table :deployments do |t|
      t.string "name", :null => false
      t.integer "site_id"
      t.integer "configParameter_id"
      t.integer "recipe_id"
      
      t.timestamps
    end
  end

  def self.down
    drop_table :deployments
  end
end
