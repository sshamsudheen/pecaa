class ProductsController < ApplicationController
  
  before_filter :ensure_site_id
  
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
      if (params[:featured])
        redirect_to featured_products_site_products_path(@site)
      else
        redirect_to site_products_path(@site)
      end
    end
  end
  
  def featured_products
    @featured_products = Product.find(:all, :conditions=>["is_featured = ?", true])
  end
  
  def search
    @products = Product.find(:all, :conditions=>["name like ?", "%#{params[:query]}%"])
    render :partial=>"search"# :text => @products.map{|i| "#{i.name}.#{i.name}\n"}
  end

end
