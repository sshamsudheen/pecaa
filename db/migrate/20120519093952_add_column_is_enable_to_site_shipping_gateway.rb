class AddColumnIsEnableToSiteShippingGateway < ActiveRecord::Migration
  def up
    remove_column(:sites_shipping_gateways, :is_enabled)
    add_column(:sites_shipping_gateways, :is_enable, :boolean, :default => false)
  end
  def down
    add_column(:sites_shipping_gateways, :is_enabled, :boolean)
    remove_column(:sites_shipping_gateways, :is_enable)
  end
  
end
