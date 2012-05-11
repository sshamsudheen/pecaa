class ApplicationController < ActionController::Base
  # protect_from_forgery
  before_filter :authenticate_user!
  before_filter :preferred_link
  
  before_filter :authorize_user, :except => [:dashbord]

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to "/logout"
  end 

  def authorize_user
    if current_user.active
    if current_user and not SubPermission.where("id in (select sub_permission_id from roles_sub_permissions where role_id=#{current_user.role_ids.join(',')})").collect(&:controller_name).include?(params[:controller])
     flash[:warning] = "You are not authorized person."
     redirect_to root_url
    end
    else
#      redirect_to '/logout'
    end
  end
  
  def preferred_link
    if params[:preferred_link] == "true"
      current_user.launch_link = request.url.split('?').first
      current_user.save
    end
  end

  def ensure_site_id
    unless @site = Site.find_by_id(params[:site_id])
     respond_to do |format|
      #format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
      end
    end
  end
  
  def ensure_product_id
    unless @product = Product.find_by_id(params[:product_id])
      render :nothing => true, :status=> 404
    end  
  end
  
end

  