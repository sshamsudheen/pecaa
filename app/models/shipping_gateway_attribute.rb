class ShippingGatewayAttribute < ActiveRecord::Base
  has_many :shipping_gateway_attribute_values
  belongs_to :shipping_gateway
  acts_as_tree
end
