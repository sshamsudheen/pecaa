class CreateShippingGatewayAttributes < ActiveRecord::Migration
  def change
    create_table :shipping_gateway_attributes do |t|
      t.integer :shipping_gateway_id
      t.string :name
      t.string :type
      t.integer :parent_id

      t.timestamps
    end
  end
end
