class SiteUsersController < ApplicationController
  before_filter :setup
  layout 'site'  
  
  def index
    @site_users = @site.site_users
    render :action => "list_users"
  end
  
  def list_users
    @site_users = @site.site_users
	if !params[:query].blank?
	@searchName	=	params[:query]
	@searchOn	=	params[:search_on]
      if params[:search_on] == "role"		
        role_ids = Role.where("name like ?", "%#{params[:query]}%").collect(&:id)
        @site_users= @site.site_users.where("id in(select user_id from roles_users where role_id in(?))", role_ids)
      else		
        @site_users= @site.site_users.where("#{params[:search_on]} like ?", "%#{params[:query]}%")
      end
    end
    if !params[:date_added].blank?
      @site_users = @site.site_users.where(:created_at => (Date.strptime(params[:start_date],"%m-%d-%Y")..Date.strptime(params[:end_date],"%m-%d-%Y")))
    end
  end
  
  def list_groups
    @site_groups = @site.site_groups.order("created_at desc")
  end
  
  def new_group
    @group = @site.site_groups.create(:name => "Group X")
    redirect_to "/sites/#{params[:site_id]}/site_users/list_groups"
  end
  
  def user_details
    @user_obj = User.find(params[:user_id])
    render :partial => 'user_details'
  end

  def group_details
    @group_obj = SiteGroup.find(params[:group_id])
    render :partial => 'group_details'
  end

  def new
    @user_obj = User.new	
  end

  def edit	
    @user_obj = User.find(params[:id])
  end

  def edit_group

    @group_obj = SiteGroup.find(params[:group_id])
    @group_obj.name = params[:name]
    @group_obj.status = (params[:groups][:active].blank? ? false : true ) rescue false
    @group_obj.role_ids = params[:group][:role_ids]  if params[:group]
    @group_obj.save
    redirect_to "/sites/#{params[:site_id]}/site_users/list_groups"
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
        s_u = SiteUser.create(:user_id=>@user_obj.id,:site_id=>params[:site_id],:name=>@user_obj.username, :site_group_ids=>params[:group_ids])
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
	@address_obj= Address.find(:all, :conditions => [ "user_id = (?)",  params[:id]])
	@address_obj.each { |o| o.destroy }	
    @user_obj = User.find(params[:id])
    @user_obj.delete
	@site_users_obj= SiteUser.find(:all, :conditions => [ "user_id = (?)",  params[:id]])
	@site_users_obj.each { |o| o.destroy }
	
    redirect_to "/sites/#{params[:site_id]}/site_users/list_users"
  end
  
  def show
    @site_user = SiteUser.find(params[:id])
    @user_obj = @site_user.user
    render :layout => false
  end

   def update
	@address_obj= Address.find(:all, :conditions => [ "user_id = (?)",  params[:usr_id]])
	@address_obj.each { |o| o.destroy }
    @user_obj = User.find(params[:usr_id])	
    params[:user][:addresses]=[params[:user][:addresses1]] << params[:user][:addresses2]
    params[:user].delete(:addresses1)
    params[:user].delete(:addresses2)
    params[:user][:role_ids] = params[:users][:role_ids] if params[:users]
    params[:user][:password] = @user_obj.password
    s_u = @user_obj.site_users.first
    s_u.site_group_ids = params[:group_ids]
    if @user_obj.update_attributes(params[:user])
      respond_to do |format|
        format.json { render :json => @user_obj.to_json, :status => 200 }
        format.xml  { head :ok }
        format.html { redirect_to :action => :index }
      end
    else
      respond_to do |format|
        format.json { render :text => "Could not create user", :status => :unprocessable_entity } # placeholder
        format.xml  { head :ok }
        format.html { render :action => :edit, :status => :unprocessable_entity }
      end
    end
  end

	
  
  protected

  def setup
    @site = Site.find(params[:site_id] || params[:id]) 
    @symbol = "Website_List"
  end
  

end
