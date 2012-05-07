class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :product_id
      t.string :size
      t.string :material
      t.string :sub_sku
      t.integer :inventory
      t.integer :trigger
      t.boolean :track_inventory
      t.boolean :allow_negative_inventory

      t.timestamps
    end
  end
end
