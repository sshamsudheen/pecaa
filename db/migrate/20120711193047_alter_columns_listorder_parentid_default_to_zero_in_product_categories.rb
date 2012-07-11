class AlterColumnsListorderParentidDefaultToZeroInProductCategories < ActiveRecord::Migration
  def up
	change_column :product_categories, :parent_id, :integer, :default => 0, :null => false
	change_column :product_categories, :list_order, :integer, :default => 0, :null => false
  end

  def down
  end
end
