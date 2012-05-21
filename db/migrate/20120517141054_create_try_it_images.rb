class CreateTryItImages < ActiveRecord::Migration
  def change
    create_table :try_it_images do |t|
      t.string :name
      t.string :hotspot_type
      t.string :left_eye_position
      t.string :right_eye_position
      t.integer  "user_id"
      t.string   "upload_file_name"
      t.string   "upload_content_type"
      t.integer  "upload_file_size"
      t.datetime "upload_updated_at"
      t.boolean  "is_deleted"
      
      t.timestamps
    end
  end
end
