class RenameCoumnToSitesPaymentGatewayId < ActiveRecord::Migration
  def up
    rename_column :site_payment_gateway_attribute_values, :site_payment_gateway_id, :sites_payment_gateway_id
  end

  def down
    rename_column :site_payment_gateway_attribute_values, :sites_payment_gateway_id, :site_payment_gateway_id
  end
end
