class AddColumnsToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :price, :float, :default => 0.0
    add_column :site_styles, :theme_id, :integer
    add_column :site_styles, :base_color_id, :integer
  end
end
