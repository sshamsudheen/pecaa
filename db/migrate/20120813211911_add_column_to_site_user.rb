class AddColumnToSiteUser < ActiveRecord::Migration
  def change
	remove_column(:site_users, :group_id, :integer)
  #add_column(:site_groups, :status, :boolean)
  end
end
