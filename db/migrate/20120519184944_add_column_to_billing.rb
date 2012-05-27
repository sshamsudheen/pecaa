class AddColumnToBilling < ActiveRecord::Migration
  def change
    add_column :billings, :card_number, :string
  end
end
