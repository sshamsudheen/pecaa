class Vendor < ActiveRecord::Base
  belongs_to :product_vendor
  belongs_to :product
end
