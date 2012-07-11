class ProductCategoriesController < ApplicationController
  
  before_filter :ensure_site_id
  
  layout "products"
  
  def index
    @product_categories = ProductCategory.where('parent_id=0').order('list_order')
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

  def reorder
    # sql hash object
    sqlhash = {}
    # lambda that digs the child nodes and builds the sql
    _dig = lambda{|p,c|
      c.each_with_index { |i,x|
        cid = i['title'][/\d+/]
        sqlhash.merge!("#{cid}"=> {'list_order'=>x+1, 'parent_id'=>p})
        if i['children'].length > 0
          _dig.call(cid, i['children'])
        end
      }
    }
    logger.info "params-data>> #{params[:data]}"
    # building the sql from the JSON posted
    JSON.load(params[:data]).each_with_index { |i,x|
      iid = i[0]['title'][/\d+/]
      sqlhash.merge!("#{iid}"=> {'list_order'=>x+1, 'parent_id'=>0})
      if i[0]['children'].length > 0
        _dig.call(iid, i[0]['children'])
      end
    }
    # update current site pages with their orders
    if !sqlhash.empty?
      logger.info "re-ordering the product-categories sqlhash>> #{sqlhash.inspect}"
      ProductCategory.update(sqlhash.keys, sqlhash.values)
    end
    render :nothing=> true
  end

end
