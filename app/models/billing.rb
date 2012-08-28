class Billing < ActiveRecord::Base
  belongs_to :order
  has_one :billing_address
  has_many :histories , :as => :entity
  liquid_methods :type_of_card, :card_number
  after_save do |billing|
    [ "method", "auth_code", "amount", "card_number"].each do |clm|
      billing.histories.create(:created_by => User.first.id,:order_id => billing.order.id,:changes_txt => "changed this #{clm} to #{billing.send(clm)}") if billing.send("#{clm}_changed?")
    end
  end
end
