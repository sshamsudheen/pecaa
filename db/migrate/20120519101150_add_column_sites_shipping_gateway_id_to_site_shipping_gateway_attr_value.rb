class AddColumnSitesShippingGatewayIdToSiteShippingGatewayAttrValue < ActiveRecord::Migration
  def change
    remove_column(:shipping_gateway_attribute_values, :site_shipping_gateway_id)
    add_column(:shipping_gateway_attribute_values, :sites_shipping_gateway_id, :integer)
  end
end
