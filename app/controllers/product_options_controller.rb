class ProductOptionsController < ApplicationController
  before_filter :ensure_site_id
  
  layout "products"
  
  def index
    @product_options = ProductOption.all
  end

  def new
    @product_option = ProductOption.new
    render :layout => false
  end

  def create
    @product_option = ProductOption.new(params[:product_option])
    if @product_option.save
      redirect_to site_product_options_path(@site)
    else
    end
  end

  def update
    @product_option = ProductOption.find(params[:id])
    if @product_option.update_attributes(params[:product_option])
      if request.xhr?
        render :nothing=> true
      else
        redirect_to site_product_options_path(@site)
      end
    else
    end
  end
  
  def update_name
    @product_option = ProductOption.find(params[:id])
    if request.xhr?
      para_hash = (params[:name] == 'true' ? {:name => params[:value]} : {:display_name=> params[:value]})
      if @product_option.update_attributes(para_hash)
        render :text => @product_option.name || ''
      end
    end
  end
  

  def destroy
    @product_option = ProductOption.find(params[:id])
    @product_option.destroy
    redirect_to site_product_options_path(@site)
  end
  
  def search
    @product_categories = ProductOption.find(:all, :conditions=>["name like ?", "%#{params[:query]}%"])
    render :action => "index"
  end

end
