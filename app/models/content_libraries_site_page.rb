class ContentLibrariesSitePage < ActiveRecord::Base
  belongs_to :site_pages
  belongs_to :content_libraries
end