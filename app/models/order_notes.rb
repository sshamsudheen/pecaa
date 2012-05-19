class OrderNotes < ActiveRecord::Base
  belongs_to :order
#  has_many :histories

#  after_save do |order_note|
#    order_note.histories.create(:created_by => User.first.id,:order_id => order_note.order.id, :changes => "#{User.first.username} added this notes '#{description}'")
#  end
end
