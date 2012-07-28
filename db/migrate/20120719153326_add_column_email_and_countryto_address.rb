class AddColumnEmailAndCountrytoAddress < ActiveRecord::Migration
  def up
    add_column(:addresses, :email, :string)
  end

  def down
    remove_column(:addresses, :email)
  end
end
