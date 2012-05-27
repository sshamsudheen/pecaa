class AddColumnIsTestModeToSiteShippingGateway < ActiveRecord::Migration
  def change
    add_column(:sites_shipping_gateways, :is_test_mode, :boolean)
  end
end
