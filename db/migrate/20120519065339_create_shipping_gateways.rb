class CreateShippingGateways < ActiveRecord::Migration
  def change
    create_table :shipping_gateways do |t|
      t.string :type

      t.timestamps
    end
  end
end
