class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authorize_user
  before_filter :check_authenticated
  before_filter :get_site
  layout "sessions"

  def new
    @site = Site.find params[:site_id]
    record = "sessions"
    build_resource({})
    @site.site_style.theme.get_files('templates')
    @content = @site.site_style.theme.read_file("#{record.downcase}.liquid", 'templates')
    @content_layout = @site.site_style.theme.read_file("layout.liquid", 'templates')

    @site_theme = get_files_to_load(@site.site_style.theme) if @site.site_style && @site.site_style.theme
    flash_message = [flash[:notice],flash[:alert]].compact.join(" <br/> ") if !flash.blank?
    icontent = Liquid::Template.parse(@content).render("#{record.downcase}" => "","site" => @site, "user" => resource,"flash_message" => flash_message )
    lcontent = Liquid::Template.parse(@content_layout).render("content_for_layout" => icontent, "site" => @site, "site_theme"=> @site_theme, "user" => resource, "errors" => resource.errors, "flash_message" => flash_message )
    render :text => lcontent
  end

  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        respond_with resource, :location => redirect_location(resource_name, resource)
      else
        set_flash_message :notice, :inactive_signed_up, :reason => inactive_reason(resource) if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      flash[:notice] = resource.errors.full_messages.join(",")
      redirect_to new_site_registration_path(@site)
    end
  end

  protected
  def after_sign_in_path_for(resource)
    site_customer_shippings_path(@site)
  end

  def get_site
    @site = Site.find params[:site_id]
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
