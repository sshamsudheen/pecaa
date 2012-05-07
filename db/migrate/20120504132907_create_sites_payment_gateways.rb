class CreateSitesPaymentGateways < ActiveRecord::Migration
  def change
    create_table :sites_payment_gateways do |t|
      t.integer :site_id
      t.integer :payment_gateway_id
      t.boolean :is_enable

      t.timestamps
    end
  end
end
