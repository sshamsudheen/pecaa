class CreateTaxGateways < ActiveRecord::Migration
  def change
    create_table :tax_gateways do |t|
      t.string :name

      t.timestamps
    end
  end
end
