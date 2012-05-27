class CreateModifierTypes < ActiveRecord::Migration
  def change
    create_table :modifier_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
