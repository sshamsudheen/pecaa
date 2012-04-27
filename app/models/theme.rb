require "ftools"
class Theme < ActiveRecord::Base
  
    def self.upload_theme(theme_options)
      file_options  = theme_options[:theme_file]
    	new_file = Theme.new(
    	       :name => theme_options[:name],
             :filename => file_options.original_filename,
             :content_type => file_options.content_type,
             :secret_code => rand_code_generator)
      if new_file.save
        File.makedirs("public/themes/#{new_file.secret_code}")
        File.cp(file_options.path, "public/themes/#{new_file.secret_code}/#{file_options.original_filename}")
        system("cd #{Rails.root}/public/themes/#{new_file.secret_code} && unzip #{file_options.original_filename}")
      end
      new_file
    end	
    
    private

    def self.rand_code_generator
    	salt = Time.now.to_s.split(//).sort_by {rand}.join
      Digest::SHA1.hexdigest(salt)
    end

end
