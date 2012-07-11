class Customer < ActiveRecord::Base
  attr_accessor :password_confirmation
  validates :email, :presence =>true,
                    :uniqueness=>true
  validates :password, :presence =>true,
                    :length => { :minimum => 5, :maximum => 40 },
                    :confirmation =>true
  validates_confirmation_of :password
  liquid_methods :name, :account_id, :shipping_address, :billing_address
  
  def shipping_address
  end
  
  def billing_address
  end

  def account_id
  end
end
