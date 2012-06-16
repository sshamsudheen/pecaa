class Product < ActiveRecord::Base
  has_many :product_images
  has_many :product_videos
  has_many :product_options
  has_many :categories
  has_many :vendors
  has_many :inventories
  has_many :related_products
  has_one  :rel_product, :class_name => 'RelatedProduct'
  
  belongs_to :site
  
  has_many :order_products
  has_many :orders, :through => :order_products
  


  
  liquid_methods :id, :name, :sku, :vendor, :sold, :viewed, :rating, :is_active, :created_at, :updated_at, :base_price,
  :retail_price, :cost, :weight, :shipping_modifier, :case_price, :description, :image_path
 
  
  def image_path
    image = self.product_images.where(:is_thumbnail => true)
    image = self.product_images.first if image.empty?
    image_path = image ? image.image_path : '/assets/productimg.jpg'
    "<img src='#{image_path}' alt='image'>"
  end
  
  def self.featured_products
    Product.where(:is_featured => true)
  end
  
end