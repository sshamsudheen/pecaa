class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :sub_permissions
  has_and_belongs_to_many :site_groups
  
  validates :name, :presence => true, :uniqueness => true

end