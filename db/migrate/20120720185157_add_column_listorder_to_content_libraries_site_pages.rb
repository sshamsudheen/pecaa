class AddColumnListorderToContentLibrariesSitePages < ActiveRecord::Migration
  def change
	add_column :content_libraries_site_pages, :list_order, :integer, :default => 0, :null => false
  end
end
