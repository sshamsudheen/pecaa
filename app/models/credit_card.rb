class CreditCard < ActiveRecord::Base
  belongs_to :order

  validates :card_number, :card_code, :expiry_month, :expiry_year, :presence => true
end
