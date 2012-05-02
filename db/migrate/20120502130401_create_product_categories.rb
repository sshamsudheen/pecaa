class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.string :name
      t.decimal :price_modifier
      t.boolean :enabled

      t.timestamps
    end
  end
end
