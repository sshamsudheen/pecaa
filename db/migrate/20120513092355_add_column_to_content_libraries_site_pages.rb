class AddColumnToContentLibrariesSitePages < ActiveRecord::Migration
  def change
    add_column :content_libraries_site_pages, :content_type, :string
  end
end
