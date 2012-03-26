class CreateSiteOptionalDetails < ActiveRecord::Migration
  def change
    create_table :site_optional_details do |t|
      t.text :key_words
      t.text :google_analytics_code
      t.text :description
      t.string :logo_alt_text
      t.string :twitter_id
      t.string :google_id
      t.string :facebook_id
      t.string :linked_in_id
      t.boolean :share
      t.integer :site_id
      t.integer :created_by
      t.timestamps
    end
  end
end
