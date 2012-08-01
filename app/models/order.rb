class Order < ActiveRecord::Base
  has_many :order_notess
  
  has_one :shipping_detial
  
  has_one :billing
  has_one :credit_card
  
  has_many :histories ,:as => :entity
  
  has_many :order_products
  has_many :products, :through => :order_products
  belongs_to :shipping_address, :class_name => "Address", :foreign_key => "shipping_address_id"
  belongs_to :billing_address, :class_name => "Address", :foreign_key => "billing_address_id"
  belongs_to :site
  belongs_to :shipping_gateway

  attr_accessor :address_same, :contact_same

  liquid_methods :id, :order_id, :created_at, :status, :total_amt, :billing_methods
    
  after_save do |order|
    [ "order_id", "status", "customer_email", "pay_status", "ship_status"].each do |clm|
      order.histories.create(:created_by => User.first.id,:order_id => order.id,:changes_txt => "changed this #{clm} to #{order.send(clm)}") if order.send("#{clm}_changed?")
    end
  end
  
  validates_associated :billing_address, :credit_card

  def total_amt
    total = 0
    self.products.each do |p| 
      total = total + p.cost.to_i + 2.50
    end
    return total
  end
  
  def self.total_on(date)
    where("date(created_at) = ?", date).to_a.sum(&:total_amt)
  end
  
  def billing_methods
    names = SitesPaymentGateway.where(:site_id => 143, :payment_gateway_id => [1,2,3]).map(&:payment_gateway).map(&:name)


    site_payment_gateway_id = SitesPaymentGateway.where(:payment_gateway_id => 4, :site_id => 143).last.id
    SitesPaymentGateway.where(:payment_gateway_id => 4, :site_id => 143).last.payment_gateway.payment_gateway_attributes.where(:name => 'friendly_name').last.id
    names  << SitePaymentGatewayAttributeValue.where(:payment_gateway_attribute_id => 8, :sites_payment_gateway_id => 13).last.value
  end

end



