class ProductImagesController < ApplicationController
  
 before_filter :ensure_site_id, :ensure_product_id
  
  # GET /product_images/new
  def new
    @product_image = ProductImage.new(:product_id => @product.id)
    render :layout => false
  end
  
  
  def create
    @image = ProductImage.new(params[:product_image])
    @image.product_id = params[:product_id]
    Image.transaction do
      if @image.save
         render :partial => 'list'
      else
        render :nothing => true
     end
    end
  end
  
end
