class CreateTaxGatewayAttributes < ActiveRecord::Migration
  def change
    create_table :tax_gateway_attributes do |t|
      t.string :name
      t.integer :tax_gateway_id

      t.timestamps
    end
  end
end
