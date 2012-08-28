class BillingAddress < ActiveRecord::Base
  belongs_to :billing_id
  liquid_methods :nickname, :address_line1, :address_line2, :city, :state, :zip, :created_at
end
