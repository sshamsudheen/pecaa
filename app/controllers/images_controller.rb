class ImagesController < ApplicationController
  layout 'pecaa_application', :except => [:new, :edit, :show]
  def index
    @images = Image.order("created_at desc").page(params[:page]).per(5)
  end
  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params[:image])
    @image.user_id = current_user
#    @site  = Site.find(params[:site_id])
    @site_page = SitePage.find(session[:site_page_id]) rescue nil
    @site = @site_page.site rescue nil
    Image.transaction do
      if @image.save
        content_lib = ContentLibrary.create({:name => @image.upload_file_name,
          :source_id => @image.id, :source_type => 'Image',
          :last_used => nil, :times_used => nil, :added_by => current_user.username})
         if @site_page
            ContentLibrariesSitePage.create(:site_id => @site.id,:content_library_id => content_lib.id, :site_page_id => @site_page.id )
            redirect_to "/sites/#{@site.id}/site_pages/#{@site_page.id}/content_libraries/search?search[source_type_equals]=Image&content_lib=#{content_lib.id}"
          else
            redirect_to content_libraries_path
          end
      else
         if params[:from_content]
            redirect_to "/sites/#{@site.id}/site_pages/#{@site_page.id}/content_libraries/search?search[source_type_equals]=Image"
          else
            redirect_to content_libraries_path
          end
#        respond_to do |format|
#          format.html  { render(:nothing => true)}
#        end
      end
    end
#  rescue
#    redirect_to content_libraries_path
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    params[:image].merge!({:user_id => current_user})
    if @image.update_attributes(params[:image])
      content_library = ContentLibrary.find_by_source_id(@image.id)
      content_library.update_attributes({:name => @image.upload_file_name,
          :last_used => nil, :times_used => nil, :added_by => current_user.username})
      redirect_to content_libraries_path
      else
        redirect_to content_libraries_path
#        respond_to do |format|
#          format.html  { render(:nothing => true)}
#        end
    end
  rescue
    redirect_to content_libraries_path
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy
    respond_to do |format|
      format.html { redirect_to(images_url) }
      format.xml  { head :ok }
    end
  end
end
