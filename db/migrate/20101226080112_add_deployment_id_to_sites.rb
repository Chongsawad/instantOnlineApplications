class AddDeploymentIdToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :deployment_id, :integer
  end

  def self.down
    remove_column :sites, :deployment_id, :integer
  end
end
