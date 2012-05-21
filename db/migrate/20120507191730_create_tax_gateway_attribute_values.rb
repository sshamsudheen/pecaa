class CreateTaxGatewayAttributeValues < ActiveRecord::Migration
  def change
    create_table :tax_gateway_attribute_values do |t|
      t.string :value
      t.integer :tax_gateway_attribute_id

      t.timestamps
    end
  end
end
