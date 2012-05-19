class AddColumnNameToShippingAttribute < ActiveRecord::Migration
  def change
    remove_column(:shipping_gateways, :type)
    add_column(:shipping_gateways, :name, :string)
  end
end
