class CreateSystemConfigs < ActiveRecord::Migration
  def change
    create_table :system_configs do |t|
      t.string :controller_title
      t.integer :image_max_size
      t.string :image_types
      t.integer :video_max_size
      t.string :video_types
      t.integer :file_max_size
      t.string :file_types
      t.string   "controller_logo_file_name"
      t.string   "controller_logo_content_type"
      t.integer  "controller_logo_file_size"
      t.datetime "controller_logo_updated_at"
      t.timestamps
    end
  end
end
