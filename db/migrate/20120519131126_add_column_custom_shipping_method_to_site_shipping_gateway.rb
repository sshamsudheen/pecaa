class AddColumnCustomShippingMethodToSiteShippingGateway < ActiveRecord::Migration
  def change
    add_column(:shipping_gateway_attribute_values, :custom_shipping_method_id, :integer)
  end
end
