class CreateShippingGatewayAttributeValues < ActiveRecord::Migration
  def change
    create_table :shipping_gateway_attribute_values do |t|
      t.integer :shipping_gateway_attribute_id
      t.string :value
      t.integer :site_shipping_gateway_id

      t.timestamps
    end
  end
end
