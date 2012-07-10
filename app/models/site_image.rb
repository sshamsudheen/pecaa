class SiteImage < ActiveRecord::Base
  belongs_to :site
  belongs_to :site_page
  belongs_to :user

  has_attached_file :upload,
                    :url => '/:attachment/:class/:id/:style_:basename.:extension',
                    :path => ':rails_root/public/:attachment/:class/:id/:style_:basename.:extension'
                    #, :styles => { :medium => '300x300', :thumb  => '150x150' }

  validates_attachment_presence :upload
  validates_attachment_size :upload, :less_than=>10.megabyte
  validates_attachment_content_type :upload, :content_type=>['image/jpeg', 'image/png', 'image/gif']
end
