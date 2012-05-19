class AddColumnParentIdToTaxAttributeValue < ActiveRecord::Migration
  def change
    add_column(:tax_gateway_attribute_values, :parent_id, :integer)
  end
end
