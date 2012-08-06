class Site < ActiveRecord::Base
  has_many :site_links, :dependent => :delete_all
  has_many :site_contacts
  has_many :site_pages
  has_one  :site_style
  has_many :site_users
  has_many :site_page_contents
  has_many :site_link_accounts
  has_one  :address
  has_many :products
  has_many :orders
  
  has_and_belongs_to_many :content_libraries
  has_many :site_groups
  has_one  :site_optional_detail
  has_many :sites_payment_gateways
  has_many :payment_gateways, :through => :sites_payment_gateways
  has_many :tax_gateway_attribute_values
  belongs_to :tax_gateway
  has_many :sites_shipping_gateways
  has_many :shipping_gateways, :through => :sites_shipping_gateways
  has_many :inventory_options
  
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by"
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :site_contacts, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  
  validates_presence_of :name
  validates_length_of :name, :maximum => 255 
  validates_length_of :description, :maximum => 1000
  
  liquid_methods :id, :name, :site_pages, :parent_pages, :get_the_styles
  
  def parent_pages
    site_pages.find(:all, :conditions=>["parent_id = ?", 0])
  end
  
  def get_the_styles
    ret = "<style>\n"
    if st = self.site_style
      k = (st.block_style[:block_opacity])
      ret +=  "body{color:##{st.text_style[:text_color]}; background-image:url(#{(Image.find_by_id(st.background_style[:bg_image]).upload rescue "")})}\n"
      ret +=  "div.box{width:70%; text-align:center; border-width: #{st.block_style[:border_width]}; border-radius: #{st.block_style[:border_radius]}; border-color: #{st.block_style[:block_color]};}"
      ret +=  "div.box{opacity: #{(k.to_i > 0) ? k.to_f/100 : 1};}"
      ret +=  "div.box{-moz-box-shadow: #{st.block_style[:box_shadow]}; -webkit-box-shadow: #{st.block_style[:box_shadow]}; box-shadow: #{st.block_style[:box_shadow]};}\n"
      ret +=  "H1 {font:normal 16px Arial, Helvetica, sans-serif; text-shadow: #{st.text_style[:text_shadow]} #ff0000;}\n"
    end
    ret += "</style>"
    ret.html_safe
  end
  
end
