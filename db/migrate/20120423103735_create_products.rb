class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.string :vendor
      t.integer :sold
      t.integer :viewed
      t.integer :rating
      t.boolean :is_active

      t.timestamps
    end
  end
end
