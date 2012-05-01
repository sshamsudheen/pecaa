class AddFileColumnsToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :secret_code, :text
    add_column :themes, :filename, :text
    add_column :themes, :content_type, :text
    add_column :themes, :is_active, :boolean, :default => true
    
  end
end
