class SitePagesListOrderDefaultToZero < ActiveRecord::Migration
  def up
	change_column :site_pages, :list_order, :integer, :default => 0, :null => false
  end

  def down
  end
end
