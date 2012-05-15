class AddColumnToSiteFeatures < ActiveRecord::Migration
  def change
    add_column :site_features, :ssl_setup, :boolean
  end
end
