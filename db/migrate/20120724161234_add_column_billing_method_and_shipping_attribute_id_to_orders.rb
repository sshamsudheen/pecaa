class AddColumnBillingMethodAndShippingAttributeIdToOrders < ActiveRecord::Migration

  def up
    add_column(:orders, :shipping_gateway_id , :integer)
    add_column(:orders, :billing_method, :string)
  end

  def down
    remove_column(:orders, :shipping_gateway_id )
    remove_column(:orders, :billing_method)
  end

end
