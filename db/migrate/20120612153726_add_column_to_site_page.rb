class AddColumnToSitePage < ActiveRecord::Migration
  def change
    add_column :site_pages, :conent_positioning, :text
  end
end
