class AddPaperclipToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :screenshot_file_name,    :string
    add_column :projects, :screenshot_content_type, :string
    add_column :projects, :screenshot_file_size,    :integer
    add_column :projects, :screenshot_updated_at,   :datetime
  end

  def self.down
  end
end
