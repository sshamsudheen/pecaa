class SiteFeaturesController < ApplicationController
  # GET /site_features
  # GET /site_features.json
  def index
    @site_features = SiteFeature.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @site_features }
    end
  end

  # GET /site_features/1
  # GET /site_features/1.json
  def show
    @site_feature = SiteFeature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @site_feature }
    end
  end

  # GET /site_features/new
  # GET /site_features/new.json
  def new
    @site_feature = SiteFeature.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site_feature }
    end
  end

  # GET /site_features/1/edit
  def edit
    @site_feature = SiteFeature.find(params[:id])
  end

  # POST /site_features
  # POST /site_features.json
  def create
    @site_feature = SiteFeature.new(params[:site_feature])

    respond_to do |format|
      if @site_feature.save
        format.html { redirect_to @site_feature, notice: 'Site feature was successfully created.' }
        format.json { render json: @site_feature, status: :created, location: @site_feature }
      else
        format.html { render action: "new" }
        format.json { render json: @site_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /site_features/1
  # PUT /site_features/1.json
  def update
    @site_feature = SiteFeature.find(params[:id])

    respond_to do |format|
      if @site_feature.update_attributes(params[:site_feature])
        format.html { redirect_to @site_feature, notice: 'Site feature was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @site_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_features/1
  # DELETE /site_features/1.json
  def destroy
    @site_feature = SiteFeature.find(params[:id])
    @site_feature.destroy

    respond_to do |format|
      format.html { redirect_to site_features_url }
      format.json { head :ok }
    end
  end
end
