class AddColumnParentIdToShippingGatewayAttributeValues < ActiveRecord::Migration
  def change
    add_column(:shipping_gateway_attribute_values, :parent_id, :integer)
  end
end
