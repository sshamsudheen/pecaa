class AddColumnMiscIdToContentLibrariesSitePages < ActiveRecord::Migration
  def change
	add_column :content_libraries_site_pages, :misc_id, :integer
  end
end
