class AddColumnsToImages < ActiveRecord::Migration
  def change
    add_column :images, :name, :string
    add_column :images, :categories, :string
  end
end
