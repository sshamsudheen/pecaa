class RelatedProduct < ActiveRecord::Base
  belongs_to :products
  belongs_to :actual_product, :class_name=>"Product", :foreign_key => :related_product_id
end
