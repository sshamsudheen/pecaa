class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.string :file_name
      t.boolean :is_primary
      t.datetime :date_added

      t.timestamps
    end
  end
end
