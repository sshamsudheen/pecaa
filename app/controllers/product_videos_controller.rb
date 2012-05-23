class ProductVideosController < ApplicationController
  before_filter :ensure_site_id, :ensure_product_id
    
  def new
    @videos = ContentLibrary.search({:source_type_equals => 'Video'}).page(params[:page]).per(7)
    @product_video = @product.product_videos.new
    render :layout => false
  end
  
  def create
    ProductVideo.transaction do
      video = Video.new(params[:product_video])
      product_vid = @product.product_videos.new
      if video.save && product_vid.save_product_video(video)
        redirect_to videos_list_site_product_path(@site, @product)
      else
        render :nothing => true
     end
    end
  end
  
  def update
    @product_video = @product.product_videos.find(params[:id])
      if @product_video.update_attributes(params[:product_video])
        redirect_to videos_list_site_product_path(@site, @product)
      end
  end
  
  def destroy
    @product_video = @product.product_videos.find(params[:id])
    @product_video.remove_p_video
    redirect_to videos_list_site_product_path(@site, @product)
  end
  
  def link_video
    ProductVideo.transaction do
      video = Video.find_by_id(params[:id])
      product_vid = @product.product_videos.new
      if video && product_vid.save_product_video(video)
        redirect_to videos_list_site_product_path(@site, @product)
      else
        render :nothing => true
     end
    end
  end
  
  
  private
  
  def ensure_product_id
    unless @product = Product.find_by_id(params[:product_id])
      render :nothing => true, :status=> 404
    end  
  end
end
