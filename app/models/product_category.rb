class ProductCategory < ActiveRecord::Base
  has_many :categories
  has_many :products, :through => :categories

  # self-joining associations:
  has_many :children, :class_name => 'ProductCategory',
           :foreign_key => 'parent_id'
  belongs_to :parent, :class_name => 'ProductCategory'

  liquid_methods :id, :products, :name, :product
  
  def product
    products.first
  end
  
  
end
