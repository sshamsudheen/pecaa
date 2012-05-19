class CreateShippingDetials < ActiveRecord::Migration
  def change
    create_table :shipping_detials do |t|
      t.string :shipping_id
      t.integer :shipping_gateway_id
      t.string :cost
      t.string :tracking_id
      t.string :status

      t.timestamps
    end
  end
end
