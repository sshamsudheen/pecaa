class AddColumnToProductFilter < ActiveRecord::Migration
  def change
    add_column :product_filters, :site_id, :integer
  end
end
