class CreateSiteGroups < ActiveRecord::Migration
  def change
    create_table :site_groups do |t|
      t.integer :site_id
      t.string :name
      t.integer :created_by

      t.timestamps
    end
  end
end
