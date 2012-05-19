class AddColumnEnableTaxAndTaxGatewayIdToSite < ActiveRecord::Migration
  def change
    add_column(:sites, :enable_tax, :boolean)
    add_column(:sites, :tax_gateway_id, :integer)
  end
end
