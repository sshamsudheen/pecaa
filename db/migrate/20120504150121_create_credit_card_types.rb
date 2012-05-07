class CreateCreditCardTypes < ActiveRecord::Migration
  def change
    create_table :credit_card_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
