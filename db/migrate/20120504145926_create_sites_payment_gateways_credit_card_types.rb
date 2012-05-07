class CreateSitesPaymentGatewaysCreditCardTypes < ActiveRecord::Migration
  def change
    create_table :sites_payment_gateways_credit_card_types do |t|
      t.integer :sites_payment_gateway_id
      t.integer :credit_card_type_id

      t.timestamps
    end
  end
end
