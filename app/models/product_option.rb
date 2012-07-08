class ProductOption < ActiveRecord::Base
  has_many :sub_product_options
  belongs_to :product

  liquid_methods :active_sub_product_options, :name
  scope :only_active, where(:is_active => true)

  def active_sub_product_options
    sub_product_options.only_active
  end

end
