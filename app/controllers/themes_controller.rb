class ThemesController < ApplicationController
  # GET /themes
  # GET /themes.json
  
  def index
    @themes = Theme.all
    @theme = Theme.new
    render :layout=>nil
  end

  def show
    @theme = Theme.find(params[:id])
  end

  def new
    @theme = Theme.new
    render :layout=>nil
  end

  def edit
    @theme = Theme.find(params[:id])
    
    @files = @theme.get_files 
    @directories = @theme.get_directories
    @selected_file = params[:file_name] || @theme.get_first_file
    @file_content = @theme.read_file(@selected_file)
    render :layout=>false
  end

  def create
    unless (params[:theme][:theme_file].original_filename.split('.').last == "zip") && 
      (@theme = Theme.upload_theme(params[:theme]))
      flash[:notice] = "Theme cannot be Uploaded... Please try again"
    else
      @theme.update_attributes(:created_by => current_user)
      flash[:message] = "Theme has been Uploaded"
    end
    redirect_to :action => "index"
  end

  def update
    @theme = Theme.find(params[:id])
    if @theme.update_theme(params)
      flash[:notice] = "Theme has been updated"
    else
      flash[:notice] = "Theme cannot be updated... Please try again"
    end
    
    redirect_to :action => "index"
  end
  
  def copy_theme
    Theme.transaction do
      copy_theme = Theme.find(params[:id])
      @theme = copy_theme.dup
      @theme.secret_code = Theme.rand_code_generator
      @theme.created_by = current_user
      if @theme.save
        @theme.make_directory(Dir.glob("#{copy_theme.get_file_path}/*"), @theme.get_file_path)
        flash[:message] = "Theme has been Uploaded"
      end
    end
    redirect_to themes_path
  end
  
  def download_theme
    @theme = Theme.find(params[:id])
    send_file(@theme.zip_file_path, :filename=>"#{@theme.filename}", :type=>"#{@theme.content_type}", :encoding=>'utf8', :stream=>'true')
  end
  
  
  
  # def destroy
  #   @theme = Theme.find(params[:id])
  #   @theme.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to themes_url }
  #     format.json { head :ok }
  #   end
  # end
end
