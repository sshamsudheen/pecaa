class SitePage < ActiveRecord::Base
  belongs_to :site
  has_many :content_libraries_site_pages
  has_many :content_libraries, :through => :content_libraries_site_pages
end

