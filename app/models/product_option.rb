class ProductOption < ActiveRecord::Base
  has_many :sub_product_options
  belongs_to :product

  scope :only_active, where(:is_active => true)
end
