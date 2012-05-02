class AddMissingPriceDetailsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :case_price, :decimal
  end
end
