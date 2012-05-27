class ProductVideo < ActiveRecord::Base
  belongs_to :product
  belongs_to :video, :foreign_key => 'source_id'
  
  def save_product_video(video)
    self.source_id = video.id
    self.name = video.source_file_name
    self.save
  end
  
  def remove_p_video
    self.destroy
  end
  
end
