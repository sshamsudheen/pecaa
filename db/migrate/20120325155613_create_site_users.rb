class CreateSiteUsers < ActiveRecord::Migration
  def change
    create_table :site_users do |t|
      t.integer :user_id
      t.integer :site_id
      t.string :name
      t.integer :created_by

      t.timestamps
    end
  end
end
