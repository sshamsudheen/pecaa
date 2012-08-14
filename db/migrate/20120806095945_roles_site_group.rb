class RolesSiteGroup < ActiveRecord::Migration

    def self.up
      create_table :roles_site_groups, :id => false do |t|
        t.references :role, :site_group
      end
    end

    def self.down
      drop_table :roles_site_groups
    end


end
