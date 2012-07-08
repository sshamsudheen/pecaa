class SubProductOption < ActiveRecord::Base
  belongs_to :product_option
  has_one :product_image
  liquid_methods :name
  scope :only_active, where(:is_active => true)

end
