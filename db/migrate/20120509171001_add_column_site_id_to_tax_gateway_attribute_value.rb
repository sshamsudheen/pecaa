class AddColumnSiteIdToTaxGatewayAttributeValue < ActiveRecord::Migration
  def change
    add_column(:tax_gateway_attribute_values, :site_id, :integer)
  end
end
