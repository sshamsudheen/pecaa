class ProductsController < ApplicationController
  
  before_filter :ensure_site_id
  before_filter :ensure_product_id, :only => [:edit, :update,:add_image,:images_list]
  
  def index
    @products = Product.all
  end
  
  # GET /products/new
  
  def new
    @product = Product.new
    @is_new_product = true
    render :layout => false
  end
  
  
  # GET /products/:id/edit
  def edit
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
  
  # GET /products/:id/edit
  def images_list
    render :partial => "images_list", :locals => {:product_images => @product.product_images} 
  end
  
  # GET /products/:id/add_image
  def add_image
    @product_image = ProductImage.new(:product_id => @product.id)
  end  
  
  # GET /products/:id/images_list
  def images_list
    render :partial => "images_list", :locals => {:product_images => @product.product_images} 
  end
  
  private
  
  def ensure_product_id
    unless @product = Product.find_by_id(params[:id])
      render :nothing => true, :status=> 404
    end  
  end

end
