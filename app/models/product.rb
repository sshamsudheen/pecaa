class Product < ActiveRecord::Base
  has_many :product_images
  has_many :product_videos
  has_many :product_options
  has_many :inventories
  has_many :related_products
  has_one  :rel_product, :class_name => 'RelatedProduct'
  
  belongs_to :site


  
  liquid_methods :created_at, :name
 
  has_many :order_products
  has_many :orders, :through => :order_products
  
  def add_image
    self.product_images.build if self.product_images.blank?
  end
  
end