class CustomShippingMethod < ActiveRecord::Base
  has_many :shipping_gateway_attribute_values
end