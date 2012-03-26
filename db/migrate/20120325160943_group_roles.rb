class GroupRoles < ActiveRecord::Migration
  def change
    create_table :groups_roles, :id => false do |t|
      t.integer :role_id
      t.integer :group_id
    end
  end
end
