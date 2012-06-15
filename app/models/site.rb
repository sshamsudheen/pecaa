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

  
end
