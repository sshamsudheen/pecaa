class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authorize_user, :require_no_authentication
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
    flash = ''
    flash = [flash[:notice],flash[:alert]].compact.join(" <br/> ") if !flash.blank?
    icontent = Liquid::Template.parse(@content).render("#{record.downcase}" => "","site" => @site, "user" => resource, "errors" => resource.errors, "flash" => flash )
    lcontent = Liquid::Template.parse(@content_layout).render("content_for_layout" => icontent, "site" => @site, "site_theme"=> @site_theme, "user" => resource, "errors" => resource.errors, "flash" => flash )
    render :text => lcontent
  end

  protected
  def after_sign_in_path_for(scope, resource)
    new_site_registration_path(@site)
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
