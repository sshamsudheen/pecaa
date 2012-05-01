class ProductsController < ApplicationController
  def index
  end
  
  
  # GET /products/new
  
  def new
    @product = Product.new
    render :layout => nil
    # respond_to do |format|
      # format.html { render :layout => false}# new.html.erb
    # end
  end

end
