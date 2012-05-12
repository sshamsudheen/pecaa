class CreateSiteFeatures < ActiveRecord::Migration
  def change
    create_table :site_features do |t|
      t.boolean :product_filtering_status
      t.integer :site_id
      t.boolean :advertising_status
      t.boolean :show_reviews_from_last_login
      t.boolean :cart_setup

      t.timestamps
    end
  end
end
