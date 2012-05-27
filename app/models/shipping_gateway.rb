class ShippingGateway < ActiveRecord::Base
  has_many :shipping_gateway_attributes

  def self.find_active_payment(gateway, payment_gateway_id)
    (find_by_name(gateway).id == payment_gateway_id.to_i) ? "active" : ""
  end
end
