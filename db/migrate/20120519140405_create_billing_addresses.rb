class CreateBillingAddresses < ActiveRecord::Migration
  def change
    create_table :billing_addresses do |t|
      t.integer :billing_id
      t.string :nickname
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
