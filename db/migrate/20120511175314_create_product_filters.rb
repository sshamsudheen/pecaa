class CreateProductFilters < ActiveRecord::Migration
  def change
    create_table :product_filters do |t|
      t.string :name
      t.string :friendly_name
      t.boolean :status
      t.integer :product_id

      t.timestamps
    end
  end
end
