class SitePage < ActiveRecord::Base
  belongs_to :site
  has_many :miscs
  has_many :content_libraries_site_pages
  has_many :content_libraries, :class_name => "ContentLibrariesSitePage"
  
  liquid_methods :id, :name
  # self-joining associations:
  has_many :children, :class_name => 'SitePage',
           :foreign_key => 'parent_id'
  belongs_to :parent, :class_name => 'SitePage'
  
end
