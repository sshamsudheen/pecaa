class CreateProductVideos < ActiveRecord::Migration
  def change
    create_table :product_videos do |t|

      t.string   :name
      t.integer  :product_id
      t.integer  :source_id
      t.boolean  :is_active,  :default => true
      t.integer  :parent_id
      t.integer  :list_order
      t.boolean  :is_primary, :default => false

      t.timestamps
    end
  end
end
