class SitesShippingGateway < ActiveRecord::Base
  has_many :shipping_gateway_attribute_values
  has_many :shipping_gateway_attributes
  belongs_to :site
  belongs_to :shipping_gateway
  attr_accessor :get_display_name_id
  liquid_methods :display_names, :get_display_name_id

  def get_value_of(attribute_name, custom_method_id= CustomShippingMethod.where(:name => 'flat_rate').last.id)
    shipping_gateway_attributes = shipping_gateway.shipping_gateway_attributes.where(:name => attribute_name).last
    shipping_gateway_attribute_value = shipping_gateway_attribute_values.where(:shipping_gateway_attribute_id => shipping_gateway_attributes.id, :custom_shipping_method_id => custom_method_id).last
    shipping_gateway_attribute_value.blank? ? "" : shipping_gateway_attribute_value.value
  end

  def custom_get_value_of(attribute_name, custom_method_id)
    shipping_gateway_attributes = shipping_gateway.shipping_gateway_attributes.where(:name => attribute_name).last
    shipping_gateway_attribute_values.where(:shipping_gateway_attribute_id => shipping_gateway_attributes.id, :custom_shipping_method_id => custom_method_id)        
  end

  def display_names
    shipping_display_names = []
    custom_displayname = []
    self.get_display_name_id = []
    Struct.new("DisplayName", :id, :value)
    shipping_display_names = shipping_gateway_att_display_name if shipping_gateway.name != 'custom_shipping'
    custom_displayname = custom_display_name if shipping_gateway.name == 'custom_shipping'
    self.get_display_name_id = (shipping_display_names + custom_displayname).flatten
  end

  def shipping_gateway_att_display_name
    display_attributes = ShippingGatewayAttribute.where("shipping_gateway_attributes.name = 'service_type'").group_by(&:shipping_gateway_id).collect do |shipping_gateway_id, shipping_gateway_attr|
      shipping_gateway_attr.last.children.map(&:id)
    end.flatten

    ShippingGatewayAttributeValue.where(:shipping_gateway_attribute_id => display_attributes, :sites_shipping_gateway_id => self.id).collect do |shipping_gateway_attribute_value|
      GetDisplayName.new(:id => shipping_gateway_attribute_value.shipping_gateway_attribute_id.to_s, :value => shipping_gateway_attribute_value.shipping_gateway_attribute.name)
    end.flatten
  end

  def custom_display_name
    display_attributes = ShippingGatewayAttribute.where("shipping_gateway_attributes.name = 'display_name'").map(&:id)
    ShippingGatewayAttributeValue.where(:shipping_gateway_attribute_id => display_attributes, :sites_shipping_gateway_id => self.id).collect do |shipping_gateway_attribute_value|
      GetDisplayName.new(:id => shipping_gateway_attribute_value.id.to_s, :value => shipping_gateway_attribute_value.value)
    end.flatten
  end


end

class GetDisplayName
  attr_accessor :id, :value
  liquid_methods :id, :value
  def initialize(options = {})
    @id = options[:id]
    @value = options[:value]
  end

  def humanize
    (value||"").humanize
  end

end