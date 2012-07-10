class SiteImagesController < ApplicationController
  # GET /site_images
  # GET /site_images.json
  def index
    @site_images = SiteImage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @site_images }
    end
  end

  # GET /site_images/1
  # GET /site_images/1.json
  def show
    @site_image = SiteImage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @site_image }
    end
  end

  # GET /site_images/new
  # GET /site_images/new.json
  def new
    @site_image = SiteImage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site_image }
    end
  end

  # GET /site_images/1/edit
  def edit
    @site_image = SiteImage.find(params[:id])
  end

  # POST /site_images
  # POST /site_images.json
  def create_old
    logger.info "site_images_create #{params.inspect}"
    site_id = params[:site_image]
    site_page_id = params[:site_page_id]
    @site_image = SiteImage.new(params[:site_image])
    

    respond_to do |format|
      if @site_image.save
        format.html { redirect_to @site_image, notice: 'Site image was successfully created.' }
        format.json { render json: @site_image, status: :created, location: @site_image }
      else
        format.html { render action: "new" }
        format.json { render json: @site_image.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @site  = Site.find(params[:site_id])
    # instead of the above statement, the following two must be followed
    #@site_page = SitePage.find(session[:site_page_id]) rescue nil
    #@site = @site_page.site rescue nil
    @site_image = SiteImage.new(params[:site_image])
    @site_image.site_id = @site.id
    @site_image.user_id = current_user
    @site_image.site_page_id = 1

    SiteImage.transaction do
      respond_to do |format|
        if @site_image.save
          format.html { redirect_to @site_image, notice: 'Site image was successfully created.' }
          format.json { render json: @site_image, status: :created, location: @site_image }
        else
          format.html { render action: 'new' }
          format.json { render json: @site_image.errors, status: :unprocessable_entity }
        end
      end
    end
    logger.info "site_images_created #{@site_image.inspect}"
  end

  # PUT /site_images/1
  # PUT /site_images/1.json
  def update
    @site_image = SiteImage.find(params[:id])

    respond_to do |format|
      if @site_image.update_attributes(params[:site_image])
        format.html { redirect_to @site_image, notice: 'Site image was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @site_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_images/1
  # DELETE /site_images/1.json
  def destroy
    @site_image = SiteImage.find(params[:id])
    @site_image.destroy

    respond_to do |format|
      format.html { redirect_to site_images_url }
      format.json { head :ok }
    end
  end
end
