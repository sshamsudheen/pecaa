class PaymentGateway < ActiveRecord::Base
  has_many :sites_payment_gateways
  has_many :sites, :through => :sites_payment_gateways
  has_many :payment_gateway_attributes
end
