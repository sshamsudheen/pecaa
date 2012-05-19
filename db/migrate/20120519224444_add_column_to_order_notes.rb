class AddColumnToOrderNotes < ActiveRecord::Migration
  def change
    add_column :order_notes, :order_id, :integer
  end
end
