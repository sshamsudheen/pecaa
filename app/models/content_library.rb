class ContentLibrary < ActiveRecord::Base
  belongs_to :source, :polymorphic => true
  has_and_belongs_to_many :sites
  has_many :content_libraries_site_pages
  has_many :site_pages, :through => :content_libraries_site_pages
  
  scope :by_source_type, lambda{ |arg|
    where(:source_type => arg)  
  }
  scope :by_name, lambda{|arg|
    where("name like ?" , "%#{arg}%")
  }
  
  liquid_methods :source_type, :get_content
  
  def get_content
    if self.source_type == "Video" && get_content = Video.find_by_id(self.source_id)
    elsif self.source_type == "Image" && get_content = Image.find_by_id(self.source_id)
    elsif self.source_type == "Text" && get_content = ActiveRecord::Base::Text.find_by_id(self.source_id)
    end
    get_content
  end
  
#  def self.search(params)
#    method_mappings = { :source_type => :by_source_type, :name => :by_name}        
#    results = ContentLibrary.search()
#    params.each do |key,value|
#      results = results.send(method_mappings[key.to_sym],value) if method_mappings[key.to_sym] and not value.blank?
#    end
#    results
#  end
  
end
