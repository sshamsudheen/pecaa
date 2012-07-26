class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :site
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by" 
  
  liquid_methods :zipcode, :state, :city, :address_two, :address_one, :firstname, :lastname, :email, :phone, :full_name
  
  def address_string
    "#{address_one} #{address_two}, #{city}, #{state}  #{zipcode}, #{country}"
  end
  
  def full_name
    [firstname,lastname].compact.join(" ")
  end

  def city_with_state
    [city,state_with_zip].compact.join(', ')
  end

  def state_with_zip
    [state,zipcode].compact.join(" ")
  end

end