class AddColumnToSiteUser < ActiveRecord::Migration
  def change
	add_column(:site_users, :group_id, :integer)
  end
end
