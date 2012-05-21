class ProductImagesController < ApplicationController
  
  before_filter :ensure_site_id, :ensure_product_id
  
  
  def new
    @product_image = @product.product_images.new
    render :layout => false
  end
  
  def create
    ProductImage.transaction do
      image = Image.new(params[:product_image])
      product_img = @product.product_images.new
      if image.save && product_img.save_product_image(image)
        redirect_to images_list_site_product_path(@site, @product)
      else
        render :nothing => true
     end
    end
  end
  
  def update
    @product_image = @product.product_images.find(params[:id])
      if @product_image.update_attributes(params[:product_image])
        redirect_to images_list_site_product_path(@site, @product)
      end
  end
  
  def destroy
    @product_image = @product.product_images.find(params[:id])
    @product_image.remove_p_img
    redirect_to images_list_site_product_path(@site, @product)
  end
  
  
  private
  
  def ensure_product_id
    unless @product = Product.find_by_id(params[:product_id])
      render :nothing => true, :status=> 404
    end  
  end
  
  
end
