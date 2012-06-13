module ShippingsHelper
  def shipping_attribute_values(shipping_gateway_attr_value, index)
    shipping_gateway_attribute_value_hash = {}
    shipping_gateway_attr_value.children.joins(:shipping_gateway_attribute).select("shipping_gateway_attributes.name, shipping_gateway_attribute_values.value").each do |attr_value|
      shipping_gateway_attribute_value_hash[attr_value.name] = attr_value.value 
    end
    shipping_gateway_attribute_value_hash["name"] = if shipping_gateway_attr_value.value.blank?
                   index % 2 == 0 ? "Ground" : "Airmail"
                 else
                   shipping_gateway_attr_value.value
                 end
    shipping_gateway_attribute_value_hash
  end

  def shipping_gateway_is_enable(is_enable)
    is_enable.blank? || is_enable == "0" ? ["off", "disable_is_enable", "0"] : ["on", "enable_is_enable", "1"]
  end
end
