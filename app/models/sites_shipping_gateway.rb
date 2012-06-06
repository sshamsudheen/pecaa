class SitesShippingGateway < ActiveRecord::Base
  has_many :shipping_gateway_attribute_values
  has_many :shipping_gateway_attributes
  belongs_to :site
  belongs_to :shipping_gateway

  def get_value_of(attribute_name, custom_method_id= CustomShippingMethod.where(:name => 'flat_rate').last.id)
    shipping_gateway_attributes = shipping_gateway.shipping_gateway_attributes.where(:name => attribute_name).last
    shipping_gateway_attribute_value = shipping_gateway_attribute_values.where(:shipping_gateway_attribute_id => shipping_gateway_attributes.id, :custom_shipping_method_id => custom_method_id).last
    shipping_gateway_attribute_value.blank? ? "" : shipping_gateway_attribute_value.value
  end

  def custom_get_value_of(attribute_name, custom_method_id)
    shipping_gateway_attributes = shipping_gateway.shipping_gateway_attributes.where(:name => attribute_name).last
    shipping_gateway_attribute_values.where(:shipping_gateway_attribute_id => shipping_gateway_attributes.id, :custom_shipping_method_id => custom_method_id)        
  end

end
