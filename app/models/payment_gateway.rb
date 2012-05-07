class PaymentGateway < ActiveRecord::Base
  has_many :sites_payment_gateways
  has_many :sites, :through => :sites_payment_gateways
  has_many :payment_gateway_attributes

  def get_value_of(attribute_name)
    payment_gateway_attribute_value = payment_gateway_attributes.where(:name => attribute_name).last.site_payment_gateway_attribute_values.last
    payment_gateway_attribute_value.blank? ? "" : payment_gateway_attribute_value.value
  end

  def self.find_active_payment(gateway, payment_gateway_id)
    (find_by_name(gateway).id == payment_gateway_id.to_i) ? "active" : ""
  end
end
