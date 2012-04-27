class ThemesController < ApplicationController
  # GET /themes
  # GET /themes.json
  layout 'site'
  before_filter :setup
  
  def index
    @themes = Theme.all
    @theme = Theme.new
  end

  def show
    @theme = Theme.find(params[:id])
  end

  def new
    @theme = Theme.new
  end

  def edit
    @theme = Theme.find(params[:id])
  end

  def create
    unless @theme = Theme.upload_theme(params[:theme])
      flash[:notice] = "Theme cannot be Uploaded... Please try again"
    else
      
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
  
  private
  
  def setup
    @site = Site.first
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
