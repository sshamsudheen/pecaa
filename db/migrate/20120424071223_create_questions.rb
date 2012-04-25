class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :add_form_id
      t.string :type
      t.string :name
      t.string :field_type
      t.text :validation
      t.boolean :mandatory

      t.timestamps
    end
  end
end
