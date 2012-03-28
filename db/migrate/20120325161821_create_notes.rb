class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.integer :user_id
      t.integer :created_by

      t.timestamps
    end
  end
end
