class AddColumnToContentLibrariesSitePage < ActiveRecord::Migration
  def change
    add_column :content_libraries_site_pages, :width, :string
    add_column :content_libraries_site_pages, :height, :string
    add_column :content_libraries_site_pages, :position, :string
    add_column :content_libraries_site_pages, :site_id, :integer
    add_column :content_libraries_site_pages, :id, :integer
    
  end
end
