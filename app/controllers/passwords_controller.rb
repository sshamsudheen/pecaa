class PasswordsController < Devise::PasswordsController
  skip_before_filter :authorize_user
  before_filter :get_site
  layout "sessions"

  def new
    @site = Site.find params[:site_id]
    record = "passwords"
    build_resource({})
    @site.site_style.theme.get_files('templates')
    @content = @site.site_style.theme.read_file("#{record.downcase}.liquid", 'templates')
    @content_layout = @site.site_style.theme.read_file("layout.liquid", 'templates')

    @site_theme = get_files_to_load(@site.site_style.theme) if @site.site_style && @site.site_style.theme
    flash_message = [flash[:notice],flash[:alert]].compact.join(" <br/> ") if !flash.blank?
    icontent = Liquid::Template.parse(@content).render("#{record.downcase}" => "","site" => @site, "user" => resource,"flash_message" => flash_message ,  "errors" => resource.errors )
    lcontent = Liquid::Template.parse(@content_layout).render("content_for_layout" => icontent, "site" => @site, "site_theme"=> @site_theme, "user" => resource,"flash_message" => flash_message, "errors" => resource.errors )
    render :text => lcontent
  end

  def get_site
    @site = Site.find params[:site_id]
  end

  def edit
    self.resource = resource_class.new
    resource.reset_password_token = params[:id]
    render_with_scope :edit
  end

  def create
    if params[:user_name]
      self.resource = resource_class.send_reset_password_instructions(params[resource_name])
    else
      self.resource = resource_class.send_reset_password_instructions(params[resource_name],'username_req')
    end

    if successful_and_sane?(resource)
      set_flash_message(:notice, :send_instructions) if is_navigational_format?
      respond_with({}, :location => after_sending_reset_password_instructions_path_for(resource_name))
    else
      flash[:notice] = resource.errors.full_messages.join(",")
      redirect_to new_site_password_path(@site)
    end
  end

  protected
  def after_sending_reset_password_instructions_path_for(resource_name)
    new_site_registration_path(@site)
  end

  def redirect_location(resource_name, resource)
    new_site_registration_path(@site)
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
