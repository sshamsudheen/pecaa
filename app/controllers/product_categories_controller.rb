class ProductCategoriesController < ApplicationController
  
  before_filter :ensure_site_id
  
  layout "products"
  
  def index
    @product_categories = ProductCategory.all
  end

  def new
    @product_category = ProductCategory.new
    render :layout=>false
  end

  def create
    @product_category = ProductCategory.new(params[:product_category])
    if @product_category.save
      redirect_to site_product_categories_path(@site)
    else
    end
  end

  def update
    @product_category = ProductCategory.find(params[:id])
    if @product_category.update_attributes(params[:product_category])
      if request.xhr?
        render :nothing=> true
      else
        redirect_to site_product_categories_path(@site)
      end
    end
  end
  
  def update_name
    @product_category = ProductCategory.find(params[:id])
    if request.xhr?
      if @product_category.update_attributes({:name => params[:value]})
        render :text => @product_category.name || ''
      end
    end
  end
  

  def destroy
    @product_category = ProductCategory.find(params[:id])
    @product_category.destroy
    redirect_to site_product_categories_path(@site)
  end
  
  def search
    @product_categories = ProductCategory.find(:all, :conditions=>["name like ?", "%#{params[:query]}%"])
    render :action => "index"
  end
  
  
end
