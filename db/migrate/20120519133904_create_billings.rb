class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.string :method
      t.integer :site_id
      t.integer :order_id
      t.string :auth_code
      t.string :amount
      t.integer :site_user_id

      t.timestamps
    end
  end
end
