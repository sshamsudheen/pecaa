class CreateTableCustomShippingMethods < ActiveRecord::Migration
  def up
    create_table :custom_shipping_methods do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :custom_shipping_methods
  end
end
