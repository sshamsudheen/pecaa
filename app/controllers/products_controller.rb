class ProductsController < ApplicationController
  
  before_filter :ensure_site_id, :only => [:index,:new,:create,:update]
  before_filter :ensure_product_id, :only => [:update]
  
  def index
    @products = Product.all
  end
  
  
  # GET /products/new
  
  def new
    @product = Product.new
    render :layout => false
  end
  
  
  # POST /products
  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to site_products_url(@site)
    else
      render :action => "new"
    end
  end
  
  # PUT /products/1
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to products_url
    else
      render :action => "edit"
    end
  end
  
  private
  
  def ensure_site_id
    unless @site = Site.find_by_id(params[:site_id])
      #format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      render :nothing => true, :status=> 404
    end  
  end
  
  def ensure_product_id
    unless @product = Product.find_by_id(params[:product_id])
      render :nothing => true, :status=> 404
    end  
  end

end
