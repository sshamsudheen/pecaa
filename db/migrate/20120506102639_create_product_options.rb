class CreateProductOptions < ActiveRecord::Migration
  def change
    create_table :product_options do |t|
      t.string :name
      t.string :display_name
      t.decimal :price_modifier

      t.timestamps
    end
  end
end
