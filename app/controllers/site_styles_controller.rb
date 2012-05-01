class SiteStylesController < ApplicationController
  before_filter :setup
   layout 'site'
  
  def index
    @style_type = params[:type] || 'background'
    @site_style = @site.site_style || SiteStyle.new
    #@site_style = @site.site_style || SiteStyle.new
  end
  
  def new
    @site_style = @site.site_style || SiteStyle.new
    if params[:type]=='image'
      render :image_form, :layout => false
    end
  end
  
  def create
    (@site.site_style ||= SiteStyle.new).attributes = {:background_style => params[:background], :text_style => params[:text], :block_style => params[:block], :site_id => params[:site_id]}
    if @site.site_style.save
      if params[:is_preview] == "true"
        redirect_to preview_site_path(@site)
      else
        redirect_to optional_site_path(@site)
      end
    end
  end
  
  def choose_theme
    unless params[:theme_id]
      @themes = Theme.limit(7)
    else
      if theme = Theme.find_by_id(params[:theme_id])
        (@site.site_style ||= SiteStyle.new).theme_id = theme.id
        @site.site_style.save
        redirect_to :action => :choose_basecolor
      end
    end
    # render :layout => false
  end
    
  def choose_basecolor
    unless params[:basecolr_id]
      @base_color = BaseColor.new
    else
      if base_color = BaseColor.find_by_id(params[:basecolr_id])
        (@site.site_style ||= SiteStyle.new).base_color_id = base_color.id
        @site.save
        redirect_to :action => :index
      end
    end
  end
  
  protected

  def setup
    @site = Site.find(params[:site_id] || params[:id])
  end
  
end
