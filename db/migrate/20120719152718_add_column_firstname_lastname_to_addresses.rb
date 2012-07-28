class AddColumnFirstnameLastnameToAddresses < ActiveRecord::Migration
  def change
    add_column(:addresses, :firstname, :string)
    add_column(:addresses, :lastname, :string)
    add_column(:addresses, :phone, :string)
  end
end
