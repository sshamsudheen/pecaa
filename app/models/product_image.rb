class ProductImage < ActiveRecord::Base  
  belongs_to :sub_product_option
  belongs_to :product
  belongs_to :image, :foreign_key => 'source_id'
  
  def save_product_image(image)
    self.source_id = image.id
    self.name = image.upload_file_name
    self.save
  end
  
  def image_path
    self.image.upload.url(:thumb).split('?')[0] 
  end
  
  def remove_p_img
    image.is_deleted = true
    image.save 
    self.destroy
  end  
  
end
