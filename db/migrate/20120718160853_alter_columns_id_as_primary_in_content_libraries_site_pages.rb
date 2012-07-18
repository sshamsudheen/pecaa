class AlterColumnsIdAsPrimaryInContentLibrariesSitePages < ActiveRecord::Migration
  def up
	change_column :content_libraries_site_pages, :id, :primary_key
  end

  def down
  end
end
