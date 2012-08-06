class Text < ActiveRecord::Base
  belongs_to :user
  has_one :content_library, :as => :source
  
  validates :description, :presence => true
  
  liquid_methods :id, :text_block_name, :description
end
