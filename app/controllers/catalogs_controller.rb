class CatalogsController < ApplicationController
  
  before_filter :ensure_site_id
  
  layout "products"
  
  def index
    @catalogs = Catalog.all
  end

  def new
    @catalog = Catalog.new
    render :layout=>false
  end

  def create
    @catalog = Catalog.new(params[:catalog])
    if @catalog.save
      redirect_to site_catalogs_path(@site)
    else
    end
  end

  def update
    @catalog = Catalog.find(params[:id])
    if @catalog.update_attributes(params[:catalog])
      redirect_to site_catalogs_path(@site)
    else
    end
  end

  def destroy
    @catalog = Catalog.find(params[:id])
    @catalog.destroy
    redirect_to site_catalogs_path(@site)
  end
  
  def search
    @product_categories = Catalog.find(:all, :conditions=>["name like ?", "%#{params[:query]}%"])
    render :action => "index"
  end

end
