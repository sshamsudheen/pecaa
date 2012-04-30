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
  end

  def create
    unless (params[:theme][:theme_file].original_filename.split('.').last == "zip") && 
      (@theme = Theme.upload_theme(params[:theme]))
      flash[:notice] = "Theme cannot be Uploaded... Please try again"
      redirect_to :action => "index"
    end
  end

  def update
    @theme = Theme.find(params[:id])

    if @theme.update_attributes(params[:theme])
    else
    end
  end
  
  def copy_theme
    @theme = Theme.find(params[:id]).dup
    if @theme.save
      
    else
      
    end
    
    redirect_to themes_path
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
