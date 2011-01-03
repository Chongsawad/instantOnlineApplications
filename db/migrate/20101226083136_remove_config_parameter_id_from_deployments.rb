class RemoveConfigParameterIdFromDeployments < ActiveRecord::Migration
  def self.up
    remove_column :deployments, :configParameter_id
  end

  def self.down
    add_column :deployments, :configParameter_id, :integer
  end
end
