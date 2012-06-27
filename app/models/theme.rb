class Theme < ActiveRecord::Base

  has_many :site_styles

  def self.upload_theme(theme_options)
    Theme.transaction do
      file_options  = theme_options[:theme_file]
      # raise file_options.inspect
    	@new_file = Theme.new(
    	       :name => theme_options[:name],
             :filename => file_options.original_filename,
             :content_type => file_options.content_type,
             :secret_code => rand_code_generator)
      if @new_file.save!
        @new_file.unzip_extract(file_options)
      end
    end
    @new_file
  end
  
  def create_template_directory
    FileUtils.cp_r("#{Rails.root}/public/templates", get_file_path)
  end
  
  def unzip_extract(file_options)
    begin
      self.make_directory(file_options.path, self.zip_file_path)
      Zip::ZipFile.open("#{get_file_path}/#{self.filename}") { |zip_file|
          zip_file.each { |f|
          f_path=File.join(get_file_path, f.name)
          FileUtils.makedirs(File.dirname(f_path))
          zip_file.extract(f, f_path)
        }
       }
       self.create_template_directory
    rescue
      FileUtils.remove_dir(get_file_path, true)
    end
  end
  
  def get_files(file_type = 'themes')
    self.create_template_directory unless File.directory?("#{self.get_file_path}/templates/") 
    Dir.new("#{self.get_file_path}").entries.map{|n| n unless File.directory?(n)}.compact
  end
  
  def get_template_files
    self.create_template_directory unless File.directory?("#{self.get_file_path}/templates/") 
    Dir.new("#{self.get_file_path}/templates").entries.map{|n| n unless File.directory?(n)}.compact
  end
  

  def get_directories
    Dir.new("#{self.get_file_path}/themes").entries.map{|n| n unless File.directory?(n)}.compact rescue []
  end
  
  def get_first_file(file_type = "themes")
    self.get_files(file_type).each do |f|
      return f if Theme.check_file_type(f)
    end
  end

  def read_file(file_name, file_type = "themes")
    lw = ""
    if File.file?("#{self.get_file_path}/#{file_type}/#{file_name}") && Theme.check_file_type(file_name)
      File.open("#{self.get_file_path}/#{file_type}/#{file_name}").each do |line|
        lw += line
      end
    end
    lw
  end
  
  def make_directory(scr_path, dest_path)
    FileUtils.makedirs(self.get_file_path)
    FileUtils.cp_r(scr_path, dest_path)
  end
      
  def get_file_path
    "#{Rails.root}/public/themes/#{self.secret_code}"
  end
  
  def get_load_path
    "/themes/#{self.secret_code}/themes"
  end
  
  def zip_file_path
    "#{self.get_file_path}/#{self.filename}"
  end
  
  def self.rand_code_generator
  	salt = Time.now.to_s.split(//).sort_by {rand}.join
    Digest::SHA1.hexdigest(salt)
  end
  
  def self.check_file_type(file_name)
    ["js", "css", "html", "liquid"].include?(file_name.downcase.split(".").last)
  end
  
  def update_theme(params)
    params[:file_type] ||= 'themes'
    Theme.transaction do
      if self.update_attributes(params[:theme])
        # raise params[:file_type].inspect

        File.open("#{self.get_file_path}/#{params[:file_type]}/#{params[:file_name]}", 'w') {|f| f.write(params[:file_content])}
        @ret_val = true
      end
    end
    @ret_val
  end
  
end
