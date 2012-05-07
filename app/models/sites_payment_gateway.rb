class SitesPaymentGateway < ActiveRecord::Base
  has_many :site_payment_gateway_attribute_values
  has_many :sites_payment_gateways_credit_card_types
  has_many :credit_card_types, :through => :sites_payment_gateways_credit_card_types
  has_many :payment_gateway_attributes
  belongs_to :site
  belongs_to :payment_gateway

  def get_value_of(attribute_name)
    payment_gateway_attributes = payment_gateway.payment_gateway_attributes.where(:name => attribute_name).last
    payment_gateway_attribute_value = site_payment_gateway_attribute_values.where(:payment_gateway_attribute_id => payment_gateway_attributes.id).last
    payment_gateway_attribute_value.blank? ? "" : payment_gateway_attribute_value.value
  end
end
