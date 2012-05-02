class ProductsController < ApplicationController
  
  before_filter :ensure_site_id, :only => [:index,:new,:create,:update]
  before_filter :ensure_product_id, :only => [:update]
  
  def index
    @products = Product.all
  end
  
  
  # GET /products/new
  
  def new
    @product = Product.new
    @site = Site.find(params[:site_id])
     respond_to do |format|
       format.html { render :layout => false}# new.html.erb
     end
  end
  
  
  # POST /products
  def create
    @product = Product.new(params[:product])
    @site = Site.find(params[:site_id])
    respond_to do |format|
      if @product.save
        format.html { redirect_to site_products_url(@site) }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  
  
  # PUT /products/1
  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to products_url, notice: 'Misc was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @misc.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  def ensure_site_id
    site_id = params[:site_id]
    @site = Site.find(site_id) if site_id
    if (site_id.blank? || @site.blank?) 
     respond_to do |format|
      #format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
      end
    end  
  end
  
  
  def ensure_product_id
    product_id = params[:product_id]
    @product = Product.find(product_id) if product_id
    if product_id.blank? || @product.blank? 
      respond_to do |format|
        #format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
        format.all { render nothing: true, status: 404 }
      end
    end  
  end

end
