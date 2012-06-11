class SitePagesController < ApplicationController
  before_filter :setup
  layout 'site'  
  
  def index
    @site_pages = @site.site_pages
  end
  
  def new
    @site_page = @site.site_pages.new
    if params[:type]=='page'
      render :page_form, :layout => false
    elsif params[:type]=='link'
      render :link_form, :layout => false
    end
  end
  
  def create
    @site_page = SitePage.new(params[:site_page])
    @site_page.site = @site
    @site_page.created_by = current_user
    if @site_page.save
      flash[:notice] = "#{@site_page.category} was successfully saved"
    else
      flash[:notice] = "Saving #{@site_page.category} was unsuccessful"
    end
    @site_pages = @site.site_pages
    render :index
  end
  
  def update
    @site_page = SitePage.find(params[:id])
    if params[:site_page][:is_home_page]
      @site.site_pages.update_all(:is_home_page => false)
    end
    if @site_page.update_attributes(params[:site_page])
      flash[:notice] = "#{@site_page.category} was successfully saved"
    else
      flash[:notice] = "Saving #{@site_page.category} was unsuccessful"
    end
    
    if request.xhr?
      render :nothing=> true
    else
      redirect_to site_site_pages_path(@site) 
    end
    
  end
  
  def copy_page
    @site_page = SitePage.find(params[:id]).dup
    if @site_page.save
      flash[:notice] = "#{@site_page.category} was successfully copied"
    else
      flash[:notice] = "Coping #{@site_page.category} was unsuccessful"
    end
    redirect_to site_site_pages_path(@site)
  end
  
  def seo_page
    @site_page = @site.site_pages.find(params[:id])
    render :layout=>false
  end
  
  def rename_page
    @site_page = @site.site_pages.find(params[:id])
    @site_page.name = params[:value]
    @site_page.save
    render :text => params[:value] || ''
  end
  
  
  def destroy
    @site_page = @site.site_pages.find(params[:id])
    @site_page.destroy
    redirect_to site_site_pages_path(@site)
  end
  
  def content_save
    @site_page = SitePage.find(params[:id])
    if params[:content_type] == "Misc"
      @site_page.content_libraries_site_pages.create(:content_type=>"Misc",:position=>params[:style_position],:site_id=>@site.id)
    else
      @site_page.content_libraries_site_pages.create(:content_library_id => params[:content_id],:position=>params[:style_position],:site_id=>@site.id)
    end
    sorting = params[:sorting_position].split(',').collect{|el| el.split('_').last}.join(';')
#    @site_page.update_attributes(:content_positioning => sorting)
    
   if (((content = ContentLibrary.find(params[:content_id])) and content.source_type == "Image") rescue nil)
    content.source.update_attributes(params[:crop].merge(:updated_at => Time.now))
   end

    if params[:is_preview] == "true"
      redirect_to preview_site_path(@site)
    else
      redirect_to site_site_styles_path(@site)
    end
  end
  
    
  protected

  def setup
    @site = Site.find(params[:site_id] || params[:id]) 
    @symbol = "Website_List"
  end
  

end
