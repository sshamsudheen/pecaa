class AddColumnsProductOptionsProductImages < ActiveRecord::Migration

  def up
    add_column :product_images,   :source_id, :integer
    add_column :product_images,   :is_active, :boolean, :default => true
    add_column :product_images,   :parent_id, :integer
    add_column :product_images,   :list_order, :integer
    add_column :product_images,   :is_thumbnail, :boolean, :default => false
    change_column :product_images,   :is_primary, :boolean, :default => false
    
    rename_column :product_images,   :file_name, :name 
    
    add_column :product_options,  :is_active, :boolean, :default => true
    add_column :product_options,  :site_id, :integer
    add_column :product_options,  :product_id, :integer
    
  end
  
  def down
    remove_column :product_images,   :source_id
    remove_column :product_images,   :is_active
    remove_column :product_images,   :parent_id
    remove_column :product_images,   :list_order
    remove_column :product_images,   :is_thumbnail
    
    rename_column :product_images,   :name, :file_name
    
    remove_column :product_options,  :is_active
    remove_column :product_options,  :site_id
    remove_column :product_options,  :product_id
  end
  
end
