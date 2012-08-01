class SitesController < ApplicationController
  layout 'pecaa_application', :except => :add_address
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
=begin
    if params[:query].blank? && params[:date_added].blank?
      @sites = Site.all
    elsif !params[:query].blank? && params[:date_added].blank?
      search_on = params[:search_on] == 'all' ? 'name like ? AND domain_name like ? AND company_name ?' : params[:search_on]
      @sites = Site.where("#{search_on}", "%#{params[:query]}%")
    elsif params[:query].blank? && !params[:date_added].blank?
      @sites = Site.where(:created_at => (Date.strptime(params[:start_date],'%m-%d-%Y').Date.strptime(params[:end_date],'%m-%d-%Y')))
    end
=end
    # building query
    search_on = ''
    q = {}
    and_flag = false
    if !params[:query].blank?
      if params[:search_on] == 'all'
        search_on += 'name LIKE :q AND domain_name LIKE :q AND company_name LIKE :q'
        q.merge!({:q=>"%#{params[:query]}%"});
      else
        search_on += params[:search_on]+' LIKE :q'
        q.merge!({:q=>"%#{params[:query]}%"});
      end
      and_flag = true
    end
    # checking last-edit range
    if params[:last_edited] == 'on'
      search_on += (and_flag ? ' AND ': '') + 'updated_at >= :last_edited_from AND updated_at <= :last_edited_to'
      q.merge!({:last_edited_from=>Date.strptime(params[:last_edited_from],'%Y-%m-%d')})
      q.merge!({:last_edited_to=>Date.strptime(params[:last_edited_to],'%Y-%m-%d')})
      and_flag = true
    end
    # checking date-created range
    if params[:date_created] == 'on'
      search_on += (and_flag ? ' AND ': '') + 'created_at >= :date_created_from AND created_at <= :date_created_to'
      q.merge!({:date_created_from=>Date.strptime(params[:date_created_from],'%Y-%m-%d')})
      q.merge!({:date_created_to=>Date.strptime(params[:date_created_to],'%Y-%m-%d')})
      and_flag = true
    end
    # want all?
    if params[:misc] != 'all'
      search_on += (and_flag ? ' AND ': '') + 'is_active = ' + (params[:misc] == 'live' ? '1' : '0')
    end
    #logger.info "search_on #{search_on}"
    #logger.info "search_on - q #{q.inspect}"
    # time to connect to DB
    if search_on.blank?
      # by default get all the sites
      @sites = Site.all
    else
      # now query it
      @sites = Site.where("#{search_on}", q)
    end

    # now time to render the view
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
    
    @site_theme = get_files_to_load(@site.site_style.theme) if @site.site_style && @site.site_style.theme
    icontent = Liquid::Template.parse(@content).render({"#{record.downcase}" => eval("#{record.classify}.all"), "featured_products" => Product.featured_products})
    lcontent = Liquid::Template.parse(@content_layout).render("content_for_layout" => icontent, "site" => @site, "site_theme"=> @site_theme, "xyz"=>"Hello Mani")
    # render :template => "/#{@site.site_style.theme.get_file_path}/templates/#{params[:file_name].downcase.singularize}.liquid", :layout => false
    render :text => lcontent
  end

  def user_actions
    @site = Site.find(params[:id])
    record = params[:file_name].split('.').first
    @site.site_style.theme.get_files('templates')
    @content = @site.site_style.theme.read_file("#{record.downcase}.liquid", 'templates')
    @content_layout = @site.site_style.theme.read_file("layout.liquid", 'templates')

    @site_theme = get_files_to_load(@site.site_style.theme) if @site.site_style && @site.site_style.theme
    icontent = Liquid::Template.parse(@content).render("#{record.downcase}" => "","site" => @site)
    lcontent = Liquid::Template.parse(@content_layout).render("content_for_layout" => icontent, "site" => @site, "site_theme"=> @site_theme)
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

  def create_customer
    Customer.create(params[:customer])    
    render :text => "Your account is created Now."
  end

  def customer_login
    email = params[:email]
    password = params[:password]
    @customer = Customer.find_by_email_and_password(params[:email],params[:password])
    if @customer
      session[:customer_id] = @customer.id
     redirect_to "/sites/#{params[:id]}/user_dashboard?file_name=user_dashboard"
    else
      redirect_to "/sites/#{params[:id]}/user_actions?file_name=user_login"
    end
  end
  
  def user_dashboard
    @site = Site.find(params[:id])
    record = params[:file_name].split('.').first
    @site.site_style.theme.get_files('templates')
    @content = @site.site_style.theme.read_file("#{record.downcase}.liquid", 'templates')
    @content_layout = @site.site_style.theme.read_file("layout.liquid", 'templates')
    #@content_layout = @content_layout + @site.site_style.theme.read_file("theme_page_heading.liquid", 'templates')
  
    @theme_heading = @site.site_style.theme.read_file("theme_page_heading.liquid", 'templates')
    @site_theme = get_files_to_load(@site.site_style.theme) if @site.site_style && @site.site_style.theme
    customer = Customer.find(session[:customer_id]) if session[:customer_id]
    icontent = Liquid::Template.parse(@content).render({"orders" => Order.limit(10), "customer" => customer})
    lcontent = Liquid::Template.parse(@content_layout).render("content_for_layout" => icontent, "content_for_filter" => filters_liquid_variables, "site" => @site, "site_theme"=> @site_theme)
    render :text => lcontent
  end

  def order_history
    @site = Site.find(params[:id])
    record = params[:file_name].split('.').first
    @site.site_style.theme.get_files('templates')
    @content = @site.site_style.theme.read_file("#{record.downcase}.liquid", 'templates')
    @content_layout = @site.site_style.theme.read_file("layout.liquid", 'templates')
    #@content_layout = @content_layout + @site.site_style.theme.read_file("theme_page_heading.liquid", 'templates')
  
    @theme_heading = @site.site_style.theme.read_file("theme_page_heading.liquid", 'templates')
    @site_theme = get_files_to_load(@site.site_style.theme) if @site.site_style && @site.site_style.theme
    customer = Customer.find(session[:customer_id]) if session[:customer_id]
    icontent = Liquid::Template.parse(@content).render({"orders" => Order.limit(10), "customer" => customer})
    lcontent = Liquid::Template.parse(@content_layout).render("content_for_layout" => icontent, "content_for_filter" => filters_liquid_variables, "site" => @site, "site_theme"=> @site_theme)
    render :text => lcontent
  end
	
  
  def show_products
    @site = Site.find(params[:id])
    record = params[:view_name]
    @site.site_style.theme.get_files('templates')
    @content = @site.site_style.theme.read_file("#{record.downcase}.liquid", 'templates')
    @content_layout = @site.site_style.theme.read_file("theme.liquid", 'templates')
    @site_theme = get_files_to_load(@site.site_style.theme) if @site.site_style && @site.site_style.theme
    icontent = Liquid::Template.parse(@content).render((liquid_variables).merge!({'site' => @site}))
    lcontent = Liquid::Template.parse(@content_layout).render({"content_for_layout" => icontent, "site" => @site, "site_theme"=> @site_theme, 
                "content_for_filter" => filters_liquid_variables}.merge!(default_liquid_variables))
    render :text => lcontent
  end
  
  def accounts
    @site = Site.find(params[:id])
    record = params[:view_name]
    @content = @site.site_style.theme.read_file("#{record.downcase}.liquid", 'templates/user')
    @site_theme = get_files_to_load(@site.site_style.theme) if @site.site_style && @site.site_style.theme
    lcontent = Liquid::Template.parse(@content).render("site" => @site, "user"=> current_user)
    render :text => lcontent
  end
  
  def add_address
    if request.post?
      address = current_user.addresses.new params[:address]
      address.save!
      redirect_to :action => :accounts, :view_name => 'user_address_book', :id => params[:id]
    else
      @address = current_user.addresses.new
    end
  end
  
  protected
  
  def default_liquid_variables
    {
      "content_for_footer" => Liquid::Template.parse(@site.site_style.theme.read_file("theme_footer.liquid", 'templates')).render(),
      "content_for_navigation" => Liquid::Template.parse(@site.site_style.theme.read_file("theme_navigation.liquid", 'templates')).render("site"=>@site),
      "content_for_header" => Liquid::Template.parse(@site.site_style.theme.read_file("theme_header.liquid", 'templates')).render(),
      "content_for_page_heading" => Liquid::Template.parse(@site.site_style.theme.read_file("theme_page_heading.liquid", 'templates')).render()
      }    
  end
  
  def liquid_variables
    case params[:view_name]
      when 'products'
        {"products" => Product.all, "featured_products" => Product.featured_products}
      when 'featured_products'
        content = render_to_string :partial => "/shared/site_content", :locals => {:site_page => @site.site_pages.first}
          {"featured_products" => Product.featured_products, "content_site_builder" => content}
      when 'product_categories'
        unless pc = ProductCategory.find_by_id(params[:qid])
          pc = ProductCategory.first
        end
        {"site"=>@site, "product_categories" => ProductCategory.all, "current_category" => params[:category] || pc.id, "content_for_filter" => filters_liquid_variables}
      when 'products_product_categories'
        {"site"=> @site, "products" => Product.all, "product_categories" => ProductCategory.all}
      when 'products-single'
        unless p = Product.find_by_id(params[:qid])
          p = Product.first
        end
        {"product" => p}
    end
  end
  
  def filters_liquid_variables
    case params[:view_name]
    when "product_categories"
      Liquid::Template.parse(@site.site_style.theme.read_file("product_category_filter.liquid", 'templates')).render({'product_categories' => ProductCategory.all, 'site'=>@site})
    when 'products', 'featured_products'
      Liquid::Template.parse(@site.site_style.theme.read_file("filter.liquid", 'templates')).render({'product_categories' => ProductCategory.all, 'site'=>@site})
   when "user_dashboard" , "user_account_settings"
       Liquid::Template.parse(@site.site_style.theme.read_file("user_navigation.liquid", 'templates')).render({'theme_heading' => @theme_heading, 'site'=>@site})
    end
  end
  
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
