class SiteGroupSiteUser < ActiveRecord::Migration
 def self.up
   create_table :site_groups_site_users, :id => false do |t|
     t.references :site_group, :site_user
   end
 end

 def self.down
   drop_table :site_groups_site_users
 end
end
