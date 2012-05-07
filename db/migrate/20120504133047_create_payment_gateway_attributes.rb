class CreatePaymentGatewayAttributes < ActiveRecord::Migration
  def change
    create_table :payment_gateway_attributes do |t|
      t.integer :payment_gateway_id
      t.string :name

      t.timestamps
    end
  end
end
