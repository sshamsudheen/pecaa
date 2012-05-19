class AddAnotherColumnToBilling < ActiveRecord::Migration
  def change
    add_column :billings, :type_of_card, :string
  end
end
