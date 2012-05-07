class SitesPaymentGateway < ActiveRecord::Base
  has_many :site_payment_gateway_attribute_values
  has_many :sites_payment_gateways_credit_card_types
  has_many :credit_card_types, :through => :sites_payment_gateways_credit_card_types
  has_many :payment_gateway_attributes
  belongs_to :site
  belongs_to :payment_gateway
end
