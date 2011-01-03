class AddDeploymentIdToConfigParameters < ActiveRecord::Migration
  def self.up
    add_column :config_parameters, :deployment_id, :integer
  end

  def self.down
    remove_column :config_parameters, :deployment_id
  end
end
