class CreateSitesShippingGateways < ActiveRecord::Migration
  def change
    create_table :sites_shipping_gateways do |t|
      t.integer :site_id
      t.integer :shipping_gateway_id
      t.boolean :is_enabled

      t.timestamps
    end
  end
end
