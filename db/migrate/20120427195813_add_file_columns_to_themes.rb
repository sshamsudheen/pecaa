class AddFileColumnsToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :secret_code, :text
    add_column :themes, :filename, :text
    add_column :themes, :content_type, :text
  end
end
