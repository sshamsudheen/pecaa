class AddColumnToHistory < ActiveRecord::Migration
  def change
    add_column :histories, :created_by, :integer
    add_column :histories, :order_id, :integer
    add_column :histories, :changes_txt, :text
  end
end
