class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :site
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by" 
  
  liquid_methods :zipcode, :state, :city, :address_two, :address_one
  
  def address_string
    "#{address_one} #{address_two}, #{city}, #{state}  #{zipcode}, #{country}"
  end
  
end