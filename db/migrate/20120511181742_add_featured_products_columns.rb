class AddFeaturedProductsColumns < ActiveRecord::Migration
  def change
    add_column :products, :is_featured, :boolean, :default => false
    add_column :products, :featured_at, :datetime
    add_column :products, :featured_text, :string
  end
end
