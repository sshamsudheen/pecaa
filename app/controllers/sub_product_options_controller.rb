class SubProductOptionsController < ApplicationController

  before_filter :ensure_site_id
  before_filter :ensure_product_option_id

  def new
    @sub_product_option = SubProductOption.new
    render :layout => false
  end

  def create
    @sub_product_option = @product_option.sub_product_options.new(params[:sub_product_option])
    if @sub_product_option.save
      redirect_to site_product_options_path(@site)
    else
    end
  end

  def update
    @sub_product_option = @product_option.sub_product_options.find(params[:id])
    if @sub_product_option.update_attributes(params[:sub_product_option])
      redirect_to site_product_options_path(@site)
    end
  end
  
  def update_price
    @sub_product_option = SubProductOption.find(params[:id])
    if request.xhr?
      para_hash = {:price_modifier_value=> params[:value]}
      if @sub_product_option.update_attributes(para_hash)
        render :text => @sub_product_option.price_modifier_value || ''
      end
    end
  end


  def destroy
    @sub_product_option = SubProductOption.find(params[:id])
    @sub_product_option.destroy
    redirect_to site_product_options_path(@site)
  end

  def search
    @sub_product_option = SubProductOption.find(:all, :conditions=>["name like ?", "%#{params[:query]}%"])
    render :action => "index"
  end
    
  private
  
  def ensure_product_option_id
    unless @product_option = ProductOption.find_by_id(params[:product_option_id])
      render :nothing => true, :status=> 404
    end  
  end
  
end
