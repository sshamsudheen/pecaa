class AddColumnShippingAttributeValueIdToOrderRanges < ActiveRecord::Migration
  def change
    add_column(:order_ranges, :shipping_gateway_attribute_value_id, :integer)
  end
end
