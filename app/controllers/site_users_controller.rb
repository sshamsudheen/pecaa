class SiteUsersController < ApplicationController
  before_filter :setup
  layout 'site'  
  
  def index
    @site_users = @site.site_users
    render :action => "list_users"
  end
  
  def list_users
    @site_users = @site.site_users
  end
  
  def list_groups
    @site_groups = @site.site_groups
  end
  
  def new_group
    @group = @site.site_groups.new
  end
  
  def user_details
    @user_obj = User.find(params[:user_id])
    render :partial => 'user_details'
  end

  def new
    @user_obj = User.new
  end
  
  def create
    params[:user][:addresses]=[params[:user][:addresses1]] << params[:user][:addresses2]
    params[:user].delete(:addresses1)
    params[:user].delete(:addresses2)
    params[:user][:role_ids] = params[:users][:role_ids] if params[:users]
    @user_obj = User.new(params[:user])
    @user_obj.role_ids = [Role.first.id] unless @user_obj.role_ids.blank?
    @user_obj.created_by = current_user
    if @user_obj.save
      if params[:site_id]
        SiteUser.create(:user_id=>@user_obj.id,:site_id=>params[:site_id],:name=>@user_obj.username)
        redirect_to "/sites/#{params[:site_id]}/site_users/list_users"
      else
        redirect_to :action => :index        
      end
    else
      if params[:site_id]
        render :template => "site_users/new", :status => :unprocessable_entity, :layout => 'site'
      else
       render :action => :new, :status => :unprocessable_entity
      end
    end
  end
  
  def delete
    @user_obj = User.find(params[:id])
    @user_obj.delete
    redirect_to "/sites/#{params[:site_id]}/site_users/list_users"
  end
  
  def show
    @site_user = SiteUser.find(params[:id])
    @user_obj = @site_user.user
    render :layout => false
  end
  
  protected

  def setup
    @site = Site.find(params[:site_id] || params[:id]) 
    @symbol = "Website_List"
  end
  

end
