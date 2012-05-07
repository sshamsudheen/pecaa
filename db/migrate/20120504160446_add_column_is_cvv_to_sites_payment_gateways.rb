class AddColumnIsCvvToSitesPaymentGateways < ActiveRecord::Migration
  def change
    add_column :sites_payment_gateways, :is_cvv, :boolean
  end
end
