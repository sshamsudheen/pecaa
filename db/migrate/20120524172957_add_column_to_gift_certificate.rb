class AddColumnToGiftCertificate < ActiveRecord::Migration
  def change
    add_column :gift_certificates, :status, :boolean
  end
end
