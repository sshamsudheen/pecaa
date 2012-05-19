class AddColumnIsEnableToSiteShippingGateway < ActiveRecord::Migration
  def change
    remove_column(:sites_shipping_gateways, :is_enabled)
    add_column(:sites_shipping_gateways, :is_enable, :boolean, :default => 0)
  end
end
