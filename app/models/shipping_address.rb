class ShippingAddress < ActiveRecord::Base
  belongs_to :shipping_detail
   liquid_methods :nickname, :address_line1, :address_line2, :city, :state, :zip
end
