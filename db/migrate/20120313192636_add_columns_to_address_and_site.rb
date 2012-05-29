class AddColumnsToAddressAndSite < ActiveRecord::Migration
  def up
    add_column :addresses, :country, :string
    add_column :addresses, :type, :string
    add_column :addresses, :site_id, :integer
    add_column :addresses, :created_by, :integer
    
    add_column :sites, :domain_name, :string
    add_column :sites, :company_name, :string

    add_index :sites, :domain_name
    add_index :sites, :name
    add_index :addresses, :created_by
    add_index :addresses, :site_id
  end
  def down
    
    # remove_index :sites, :domain_name
    # remove_index :sites, :name
    # remove_index :addresses, :created_by
    # remove_index :addresses, :site_id
    # 
    # remove_column :addresses, :country
    # remove_column :addresses, :type
    # remove_column :addresses, :site_id
    # remove_column :addresses, :created_by
    # 
    # remove_column :sites, :domain_name
    # remove_column :sites, :company_name

  end
  
end
