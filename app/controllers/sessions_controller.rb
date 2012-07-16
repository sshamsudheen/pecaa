class SessionsController < Devise::SessionsController
  skip_before_filter :authorize_user
  before_filter :get_site
  layout "sessions"

  def get_site
    @site = Site.find params[:site_id]
  end

  protected
  def controller_path
    "Registrations"
  end

  def redirect_location(resource_name, resource)
    site_carts_path(@site)
  end


end
