class AddPriceColumnCategory < ActiveRecord::Migration
  def up
    
    remove_column :product_categories, :price_modifier
    remove_column :product_options, :price_modifier
    
    add_column :product_categories, :price_modifier, :string
    add_column :product_categories, :price_modifier_value, :decimal
    add_column :product_options, :price_modifier, :string
    
    add_column :products, :description, :text
    add_column :products, :enable_inventory, :boolean, :default => true
    add_column :products, :enable_product_options, :boolean, :default => true
    add_column :products, :enable_related_products, :boolean, :default => true
    add_column :products, :enable_try_it_on, :boolean, :default => true
    add_column :products, :auto_relate_products, :boolean, :default => true
    add_column :products, :custom_relate_products, :boolean, :default => true
    
    add_column :categories, :product_id, :integer
    add_column :categories, :product_category_id, :integer
    
    add_column :vendors, :product_id, :integer
    add_column :vendors, :product_vendor_id, :integer
    
    
  end

  def down
    remove_column :product_categories, :price_modifier_value
    
    remove_column :products, :description
    remove_column :products, :enable_inventory
    remove_column :products, :enable_product_options
    remove_column :products, :enable_related_products
    remove_column :products, :enable_try_it_on
    remove_column :products, :auto_relate_products
    remove_column :products, :custom_relate_products
    
    remove_column :categories, :product_id
    remove_column :categories, :product_category_id
    
    remove_column :vendors, :product_id
    remove_column :vendors, :product_vendor_id
  end
  
end
