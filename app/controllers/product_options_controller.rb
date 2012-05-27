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
      redirect_to site_product_options_path(@site)
    else
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
