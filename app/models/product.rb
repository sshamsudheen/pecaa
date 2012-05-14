class Product < ActiveRecord::Base
  has_many :product_images
  
  def add_image
    self.product_images.build if self.product_images.blank?
  end
  
end
