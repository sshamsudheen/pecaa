class SiteUser < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  has_and_belongs_to_many :site_groups
end
