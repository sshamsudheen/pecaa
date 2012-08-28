class ShippingGateway < ActiveRecord::Base
  has_many :shipping_gateway_attributes
  liquid_methods :name

  def self.find_active_payment(gateway, payment_gateway_id)
    (find_by_name(gateway).id == payment_gateway_id.to_i) ? "active" : ""
  end

  def display_name
    display_attributes = shipping_gateway_attributes.where("shipping_gateway_attributes.name = 'service_type'").last.children.map(&:id)
    ShippingGatewayAttributeValue.where(:shipping_gateway_attribute_id => display_attributes).map(&:shipping_gateway_attribute).collect do |shipping_gateway_attribute|
      {shipping_gateway_attribute.id => shipping_gateway_attribute.name}
    end
  end

  def custom_display_name
    display_attributes = shipping_gateway_attributes.where("shipping_gateway_attributes.name = 'display_name'").map(&:id)
    ShippingGatewayAttributeValue.where(:shipping_gateway_attribute_id => display_attributes).map(&:value)
  end
end
