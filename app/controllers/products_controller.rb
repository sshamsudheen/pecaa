class ProductsController < ApplicationController
  def index
  end
  
  
  # GET /products/new
  
  def new
    # temporary fix 
    @product = Product.new
    respond_to do |format|
      format.html { render :layout => false}# new.html.erb
    end
  end

end
