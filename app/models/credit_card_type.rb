class CreditCardType < ActiveRecord::Base
  has_many :sites_payment_gateways_credit_card_types
  has_many :sites_payment_gateways, :through => :sites_payment_gateways_credit_card_types
end
