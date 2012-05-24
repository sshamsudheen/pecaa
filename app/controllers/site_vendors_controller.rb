class SiteVendorsController < ApplicationController
  # GET /site_vendors
  # GET /site_vendors.json
  layout 'features'
  def index
    @site_vendors = SiteVendor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @site_vendors }
    end
  end

  # GET /site_vendors/1
  # GET /site_vendors/1.json
  def show
    @site_vendor = SiteVendor.find(params[:id])

    render :layout => false
  end

  # GET /site_vendors/new
  # GET /site_vendors/new.json
  def new
    @site_vendor = SiteVendor.new
    render :layout => false
  end

  # GET /site_vendors/1/edit
  def edit
    @site_vendor = SiteVendor.find(params[:id])
    render :layout => false
  end

  # POST /site_vendors
  # POST /site_vendors.json
  def create
    @site_vendor = SiteVendor.new(params[:site_vendor])

    respond_to do |format|
      if @site_vendor.save
        format.html { redirect_to "/sites/#{params[:site_id]}/site_vendors", notice: 'Site vendor was successfully created.' }
        format.json { render json: @site_vendor, status: :created, location: @site_vendor }
      else
        format.html { render action: "new" }
        format.json { render json: @site_vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /site_vendors/1
  # PUT /site_vendors/1.json
  def update
    @site_vendor = SiteVendor.find(params[:id])

    respond_to do |format|
      if @site_vendor.update_attributes(params[:site_vendor])
        format.html { redirect_to "/sites/#{params[:site_id]}/site_vendors", notice: 'Site vendor was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @site_vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_vendors/1
  # DELETE /site_vendors/1.json
  def destroy
    @site_vendor = SiteVendor.find(params[:id])
    @site_vendor.destroy

    respond_to do |format|
      format.html { redirect_to site_vendors_url }
      format.json { head :ok }
    end
  end
end
