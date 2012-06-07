class Image < ActiveRecord::Base
  belongs_to :user
  
  has_one :content_library, :as => :source
  has_one :product_image
  
  has_attached_file :upload, :styles => { :medium => "300x300", :thumb  => "150x150" }, :processors => [:cropper] 
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h                                   
  
  after_update :reprocess_avatar, :if => :cropping?  
  
  
  validates_attachment_presence :upload
  validates_attachment_size :upload, :less_than=>10.megabyte
  #validates_attachment_content_type :upload, :content_type=>['image/jpeg', 'image/png', 'image/gif', 'application/pdf', 'application/doc', 'application/docx']
  validates_attachment_content_type :upload, :content_type=>['image/jpeg', 'image/png', 'image/gif']
  
  def cropping?  
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?  
  end  
  
  private  
  def reprocess_avatar  
    upload.reprocess!  
  end  
end
