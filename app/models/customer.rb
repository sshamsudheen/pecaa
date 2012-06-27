class Customer < ActiveRecord::Base
  attr_accessor :password_confirmation
  validates :email, :presence =>true,
                    :uniqueness=>true
  validates :password, :presence =>true,
                    :length => { :minimum => 5, :maximum => 40 },
                    :confirmation =>true
  validates_confirmation_of :password
end
