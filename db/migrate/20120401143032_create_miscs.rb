class CreateMiscs < ActiveRecord::Migration
  def change
    create_table :miscs do |t|
      t.integer :user_id
      t.string :title
      t.text :address
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
