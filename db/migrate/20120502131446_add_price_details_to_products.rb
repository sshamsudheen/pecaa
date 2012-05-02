class AddPriceDetailsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :base_price, :decimal
    add_column :products, :retail_price, :decimal
    add_column :products, :cost, :decimal
    add_column :products, :weight, :decimal
    add_column :products, :shipping_modifier, :decimal
  end
end
