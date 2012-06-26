class ProductCategory < ActiveRecord::Base
  has_many :categories
  has_many :products, :through => :categories
  
  liquid_methods :id, :products, :name
  
end
