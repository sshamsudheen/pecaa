class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :product_id
      t.text :description
      t.integer :rating
      t.boolean :approved

      t.timestamps
    end
    20.times.each do 
      Review.create(:user_id=>User.first.id,:product_id => Product.first.id,:approved=>true,:description=>"over all i thought that over all i thought that over all i thought that over all i thought thatover all i thought that over all i thought thatover all i thought that over all i thought thatover all i thought that over all i thought thatover all i thought that over all i thought thatover all i thought that over all i thought thatover all i thought that over all i thought that")
    end
  end
end
