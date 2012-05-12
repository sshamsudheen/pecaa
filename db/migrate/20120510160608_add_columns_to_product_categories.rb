class AddColumnsToProductCategories < ActiveRecord::Migration
  def change
    add_column :product_categories, :parent_id, :integer
    add_column :product_categories, :list_order, :integer
    add_column :product_categories, :site_id, :integer
    add_column :products, :product_category_id, :integer
    add_column :products, :site_id, :integer
    add_column :product_categories, :is_active, :boolean, :default => true
    
  end
end
