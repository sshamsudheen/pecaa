class PaymentGatewayAttribute < ActiveRecord::Base
  belongs_to :payment_gateway
  has_many :site_payment_gateway_attribute_values
end
