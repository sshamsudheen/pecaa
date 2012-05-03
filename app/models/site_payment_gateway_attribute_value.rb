class SitePaymentGatewayAttributeValue < ActiveRecord::Base
  belongs_to :site_payment_gateway
  belongs_to :payment_gateway_attribute
end
