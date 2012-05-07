class PaymentGateway < ActiveRecord::Base
  has_many :sites_payment_gateways
  has_many :sites, :through => :sites_payment_gateways
  has_many :payment_gateway_attributes

  

  def self.find_active_payment(gateway, payment_gateway_id)
    (find_by_name(gateway).id == payment_gateway_id.to_i) ? "active" : ""
  end
end
