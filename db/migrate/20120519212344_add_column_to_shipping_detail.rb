class AddColumnToShippingDetail < ActiveRecord::Migration
  def change
    add_column :shipping_detials, :order_id, :integer
  end
end
