class ProductOption < ActiveRecord::Base
  has_many :sub_product_options
  belongs_to :product
end
