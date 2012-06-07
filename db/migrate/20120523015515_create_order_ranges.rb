class CreateOrderRanges < ActiveRecord::Migration
  def change
    create_table :order_ranges do |t|
      t.string :start_range
      t.string :end_range
      t.string :shipping_amount

      t.timestamps
    end
  end
end
