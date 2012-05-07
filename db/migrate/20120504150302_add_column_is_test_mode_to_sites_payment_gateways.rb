class AddColumnIsTestModeToSitesPaymentGateways < ActiveRecord::Migration
  def change
    add_column :sites_payment_gateways, :is_test_mode, :boolean
    add_column :sites_payment_gateways, :authorize_funds_only, :boolean
  end
end
