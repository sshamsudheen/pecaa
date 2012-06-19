class SitesController < ApplicationController
  layout 'pecaa_application'
  before_filter :setup
  
  def index
    @sites = Site.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @sites }
    end
  end

  def show
    @site = Site.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @site }
    end
  end

  def new
    @site = Site.new
    @link_accounts = @site.site_link_accounts
    # 3.times do 
      @site.site_contacts.build
    # end
    respond_to do |format|
      format.html {render :layout=>"site"}
    end
  end

  def edit
    @site = Site.find(params[:id])
    session[:site_id] = @site.id
    @link_accounts = @site.site_link_accounts
    
    respond_to do |format|
      format.html {render :layout=>"site"}
    end
  end

  def create
    @site = Site.new(params[:site])
    @site.created_by = current_user
    respond_to do |format|
      @site.transaction do 
        if @site.save
          params[:site_link_accounts].split(',').uniq.each do |s|
             sla = SiteLinkAccount.create(:user_id => s.split('_')[0].to_i, :access=>s.split('_')[1], :created_by => current_user)
             @site.site_link_accounts << sla
          end
          
          format.html { redirect_to site_site_pages_path(@site), :notice => 'Site was successfully created.' }
        else
          format.html { render :action => "new", :layout=>"site" }
        end
      end
    end
  end

  def update
    @site = Site.find(params[:id])
    session[:site_id] = @site.id
    respond_to do |format|
      if @site.update_attributes(params[:site])
        if params[:site_pages]
          if params[:is_preview] == "true"
            path_to = preview_site_path(@site)
          else
            path_to = search_site_site_page_content_libraries_path(@site, @site.site_pages.first)
          end
        else
          path_to = site_site_pages_path(@site)
        end
        format.html { redirect_to path_to, :notice => 'Site was successfully updated.' }
      else
        format.html { render :action => "edit", :layout=>"site"}
      end
    end
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :ok }
    end
  end
  
  def search
    if params[:query].blank? && params[:date_added].blank?
      @sites = Site.all
    elsif !params[:query].blank? && params[:date_added].blank?
      @sites = Site.where("#{params[:search_on]} like ?", "%#{params[:query]}%")
    elsif params[:query].blank? && !params[:date_added].blank?
      @sites = Site.where(:created_at => (Date.strptime(params[:start_date],"%m-%d-%Y").Date.strptime(params[:end_date],"%m-%d-%Y")))
    end
    render :action => 'index'
  end
  
  def preview
    @site = Site.find(params[:id])
    @site_page = params[:page_id] ? @site.site_pages.find(params[:page_id]) : @site.site_pages.first
    @site_theme = get_files_to_load(@site.site_style.theme) if @site.site_style && @site.site_style.theme
    render :layout => false
  end
  
  def site_preview
    @site = Site.find(params[:id])
    record = params[:file_name].split('.').first
    @site.site_style.theme.get_files('templates')
    @content = @site.site_style.theme.read_file("#{record.downcase}.liquid", 'templates')
    @content_layout = @site.site_style.theme.read_file("layout.liquid", 'templates')
    
    #     @site.site_style.theme.get_files('themes')
    #     @content = @site.site_style.theme.read_file("#{record.downcase}.liquid", 'themes')
    #     @site.site_style.theme.get_files('')
    #     @content = @site.site_style.theme.read_file("#{record.downcase}.liquid", '')
    
    icontent = Liquid::Template.parse(@content).render("#{record.downcase}" => eval("#{record.classify}.all"), "featured_products" => Product.featured_products)
    lcontent = Liquid::Template.parse(@content_layout).render("content_for_layout" => icontent)
    
    # render :template => "/#{@site.site_style.theme.get_file_path}/templates/#{params[:file_name].downcase.singularize}.liquid", :layout => false
    render :text => lcontent
  end
  
  
  def rendering_partial
    render :partial => "contact_form"
  end
  
  def site_link_account
    @site = Site.find(params[:site_id])
    if SiteLinkAccount.save_link(params)
      @link_accounts = @site.site_link_accounts
      render :partial => "link_accounts"
    end
  end
  
  def optional
    @site = Site.find(params[:id])
    @optional = @site.site_optional_detail || SiteOptionalDetail.new
    render :layout => "site"
  end

  def optional_create
    @site = Site.find(params[:id])
    if (@optional = @site.site_optional_detail) 
      @optional.update_attributes(patams[:optional])
    else
      params[:optional][:site_id] = params[:id]
      @optional = SiteOptionalDetail.create(params[:optional])
    end
    redirect_to "/sites/#{params[:id]}/site_users/list_users"
  end

  def done
    @site = Site.find(params[:id])
    render :layout => "site"
  end
  
  protected

  def setup
    @symbol="Website_List"
  end
  
  def get_files_to_load(theme)
    files = ""
    theme.get_files.each do |n|
      if Theme.check_file_type(n)
        case (n.split('.').last.downcase)
          when 'js'
            files += "<script type='text/javascript' src='#{theme.get_load_path}/#{n}'></script>"
          when 'css'
            files += "<link rel='stylesheet' href='#{theme.get_load_path}/#{n}' type='text/css'>"
        end
      end
    end
    files.blank? ? nil : files.html_safe
  end
  
end
