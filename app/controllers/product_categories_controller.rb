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
      redirect_to site_product_categories_path(@site)
    else
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
