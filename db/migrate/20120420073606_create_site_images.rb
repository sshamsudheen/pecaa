class CreateSiteImages < ActiveRecord::Migration
  def change
    create_table :site_images do |t|
      t.integer :site_id
      t.integer :site_page_id
      t.integer :user_id
      t.string :upload_file_name
      t.string :upload_content_type
      t.integer :upload_file_size

      t.timestamps
    end
  end
end
