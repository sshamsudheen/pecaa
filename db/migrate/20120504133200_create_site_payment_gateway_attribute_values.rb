class CreateSitePaymentGatewayAttributeValues < ActiveRecord::Migration
  def change
    create_table :site_payment_gateway_attribute_values do |t|
      t.integer :site_payment_gateway_id
      t.integer :payment_gateway_attribute_id
      t.string :value

      t.timestamps
    end
  end
end
