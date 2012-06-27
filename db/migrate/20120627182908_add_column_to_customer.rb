class AddColumnToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :site_id, :integer
  end
end
