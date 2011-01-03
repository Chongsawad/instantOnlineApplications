class RemoveSiteIdFromDeployments < ActiveRecord::Migration
  def self.up
    remove_column :deployments, :site_id
  end

  def self.down
    add_column :deployments, :site_id, :integer
  end
end
