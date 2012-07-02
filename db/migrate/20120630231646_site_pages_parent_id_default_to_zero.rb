class SitePagesParentIdDefaultToZero < ActiveRecord::Migration
  def up
	change_column :site_pages, :parent_id, :integer, :default => 0, :null => false
  end

  def down
  end
end
