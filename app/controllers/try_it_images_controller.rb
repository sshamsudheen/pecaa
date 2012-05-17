class TryItImagesController < ApplicationController
  # GET /try_it_images
  # GET /try_it_images.json
  layout 'features'
  def index
    @try_it_images = TryItImage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @try_it_images }
    end
  end

  # GET /try_it_images/1
  # GET /try_it_images/1.json
  def show
    @try_it_image = TryItImage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @try_it_image }
    end
  end

  # GET /try_it_images/new
  # GET /try_it_images/new.json
  def new
    @try_it_image = TryItImage.new
    render :layout => false
  end

  # GET /try_it_images/1/edit
  def edit
    @try_it_image = TryItImage.find(params[:id])
    render :layout => false
  end

  # POST /try_it_images
  # POST /try_it_images.json
  def create
    @try_it_image = TryItImage.new(params[:try_it_image])

    respond_to do |format|
      if @try_it_image.save
        format.html { redirect_to "/sites/#{params[:site_id]}/try_it_images", notice: 'Try it image was successfully created.' }
        format.json { render json: @try_it_image, status: :created, location: @try_it_image }
      else
        format.html { render action: "new" }
        format.json { render json: @try_it_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /try_it_images/1
  # PUT /try_it_images/1.json
  def update
    @try_it_image = TryItImage.find(params[:id])

    respond_to do |format|
      if @try_it_image.update_attributes(params[:try_it_image])
        format.html { redirect_to "/sites/#{params[:site_id]}/try_it_images", notice: 'Try it image was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @try_it_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /try_it_images/1
  # DELETE /try_it_images/1.json
  def destroy
    @try_it_image = TryItImage.find(params[:id])
    @try_it_image.destroy

    respond_to do |format|
      format.html { redirect_to try_it_images_url }
      format.json { head :ok }
    end
  end
end
