class AddColumnNameToShippingAttribute < ActiveRecord::Migration
  def up
    remove_column(:shipping_gateways, :type)
    add_column(:shipping_gateways, :name, :string)
  end
  
  def down
    add_column(:shipping_gateways, :type, :string)
    remove_column(:shipping_gateways, :name)
  end
  
end
