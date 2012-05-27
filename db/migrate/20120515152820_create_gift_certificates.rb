class CreateGiftCertificates < ActiveRecord::Migration
  def change
    create_table :gift_certificates do |t|
      t.integer :site_id
      t.string :certificate_id
      t.datetime :expired_date
      t.string :purchased_by
      t.integer :assigned_to
      t.string :value

      t.timestamps
    end
  end
end
