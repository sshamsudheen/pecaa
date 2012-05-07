class SitesPaymentGatewaysCreditCardType < ActiveRecord::Base
  belongs_to :credit_card_type
  belongs_to :sites_payment_gateway
end
