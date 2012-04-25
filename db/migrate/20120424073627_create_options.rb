class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :name
      t.integer :question_id
      t.integer :created_by

      t.timestamps
    end
  end
end
