class SiteGroup < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :users
  belongs_to :site
end
