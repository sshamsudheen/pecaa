class CreateSubProductOptions < ActiveRecord::Migration
  def change
    create_table :sub_product_options do |t|
      t.integer  :site_id
      t.integer  :parent_id
      t.integer  :list_order
      t.integer  :product_option_id
      t.string   :sub_sku
      t.integer  :product_image_id
      t.decimal  :price_modifier_value
      t.string   :price_modifier
      t.string   :name
      t.boolean  :is_active, :default=>true
      
      t.timestamps
    end
  end
end
