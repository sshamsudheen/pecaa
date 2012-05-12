class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.integer :site_id
      t.boolean :is_active, :default => true
      t.string  :name
      t.string  :supplier_name
      t.decimal :price_modifier

      t.timestamps
    end
  end
end
