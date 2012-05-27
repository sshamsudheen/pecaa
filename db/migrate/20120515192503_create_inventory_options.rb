class CreateInventoryOptions < ActiveRecord::Migration
  def change
    create_table :inventory_options do |t|
      t.integer :site_id
      t.string :trigger_email
      t.string :inventory_level
      t.string :trigger_level
      t.boolean :track_status
      t.boolean :allow_negative
      t.boolean :show_inventory
      t.string :low_inventory_text
      t.string :low_inventory_trigger
      t.string :out_of_stock_text

      t.timestamps
    end
  end
end
