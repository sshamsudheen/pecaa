class ShippingDetial < ActiveRecord::Base
  belongs_to :order
  has_one :shipping_address
  belongs_to :shipping_gateway

  has_many :histories, :as => :entity
  
  
  after_save do |shipping_detail|
    [ "shipping_id", "status", "tracking_id", "cost"].each do |clm|
      shipping_detail.histories.create(:created_by => User.first.id,:order_id => shipping_detail.order.id,:changes_txt => "changed this #{clm} to #{shipping_detail.send(clm)}") if shipping_detail.send("#{clm}_changed?")
    end
  end
end
