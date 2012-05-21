class AddColumnIsEnableToTaxAttributeValue < ActiveRecord::Migration
  def change
    add_column(:tax_gateway_attribute_values, :is_enable, :boolean, :default => 0)
  end
end
