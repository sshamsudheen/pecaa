require "ftools"
# require 'zip/zip' 
class Theme < ActiveRecord::Base
  
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
          file_path="public/themes/#{@new_file.secret_code}"
          begin
          File.makedirs("#{file_path}")
          File.cp(file_options.path, "#{file_path}/#{file_options.original_filename}")
          Zip::ZipFile.open("#{file_path}/#{file_options.original_filename}") { |zip_file|
              zip_file.each { |f|
              f_path=File.join(file_path, f.name)
              File.makedirs(File.dirname(f_path))
              zip_file.extract(f, f_path) #unless File.exist?(f_path)
            }
           }
          rescue
            FileUtils.remove_dir(file_path, true )
          end
        end
      end
      @new_file
    end	
    
    private

    def self.rand_code_generator
    	salt = Time.now.to_s.split(//).sort_by {rand}.join
      Digest::SHA1.hexdigest(salt)
    end

end
