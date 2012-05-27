class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :site_id
      t.string :code
      t.string :free_text
      t.datetime :expired_at
      t.integer :created_by
      t.string :coupon_type
      t.string :amount
      t.boolean :multi_use
      t.integer :no_of_users

      t.timestamps
    end
  end
end
