class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :entity_id
      t.string :entity_type

      t.timestamps
    end
  end
end
