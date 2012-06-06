class CreateCustomShippingRanges < ActiveRecord::Migration
  def change
    create_table :custom_shipping_ranges do |t|
      t.string :start_range
      t.string :end_range
      t.string :shipping_amount
      t.integer :shipping_gateway_attribute_value_id

      t.timestamps
    end
  end
end
