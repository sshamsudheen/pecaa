class CreateSiteVendors < ActiveRecord::Migration
  def change
    create_table :site_vendors do |t|
      t.string :name
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone_number
      t.string :email
      t.string :account_number
      t.boolean :status
      t.integer :site_id

      t.timestamps
    end
  end
end
