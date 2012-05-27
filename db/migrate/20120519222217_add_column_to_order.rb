class AddColumnToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :grand_total, :string
  end
end
