class AddColumnToMisc < ActiveRecord::Migration
  def change
    add_column :miscs, :site_page_id, :integer
    add_column :miscs, :site_id, :integer
  end
end
