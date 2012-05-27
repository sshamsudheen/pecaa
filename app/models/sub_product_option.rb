class SubProductOption < ActiveRecord::Base
  belongs_to :product_option
  has_one :product_image
end
