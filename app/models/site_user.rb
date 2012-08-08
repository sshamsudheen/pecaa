class SiteUser < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  has_many :site_groups
end
