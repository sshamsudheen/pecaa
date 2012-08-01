class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.integer :order_id
      t.string :card_number
      t.string :card_code
      t.string :expiry_month
      t.string :expiry_year
      t.string :promotional_code

      t.timestamps
    end
  end
end
