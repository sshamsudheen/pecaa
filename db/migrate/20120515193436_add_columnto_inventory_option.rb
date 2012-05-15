class AddColumntoInventoryOption < ActiveRecord::Migration
  def up
    add_column "inventory_options", "enable_inventory", :boolean    
  end

  def down
  end
end
