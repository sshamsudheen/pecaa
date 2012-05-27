class ShippingAddress < ActiveRecord::Base
  belongs_to :shipping_detail
end
