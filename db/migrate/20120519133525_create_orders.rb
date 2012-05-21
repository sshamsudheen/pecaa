class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :site_id
      t.string :order_id
      t.string :status
      t.string :customer_email
      t.string :pay_status
      t.string :ship_status
      t.integer :site_user_id

      t.timestamps
    end
  end
end
