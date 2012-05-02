class ProductVendorsController < ApplicationController
  # GET /product_vendors
  # GET /product_vendors.json
  def index
    @product_vendors = ProductVendor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_vendors }
    end
  end

  # GET /product_vendors/1
  # GET /product_vendors/1.json
  def show
    @product_vendor = ProductVendor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_vendor }
    end
  end

  # GET /product_vendors/new
  # GET /product_vendors/new.json
  def new
    @product_vendor = ProductVendor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_vendor }
    end
  end

  # GET /product_vendors/1/edit
  def edit
    @product_vendor = ProductVendor.find(params[:id])
  end

  # POST /product_vendors
  # POST /product_vendors.json
  def create
    @product_vendor = ProductVendor.new(params[:product_vendor])

    respond_to do |format|
      if @product_vendor.save
        format.html { redirect_to @product_vendor, notice: 'Product vendor was successfully created.' }
        format.json { render json: @product_vendor, status: :created, location: @product_vendor }
      else
        format.html { render action: "new" }
        format.json { render json: @product_vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_vendors/1
  # PUT /product_vendors/1.json
  def update
    @product_vendor = ProductVendor.find(params[:id])

    respond_to do |format|
      if @product_vendor.update_attributes(params[:product_vendor])
        format.html { redirect_to @product_vendor, notice: 'Product vendor was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_vendors/1
  # DELETE /product_vendors/1.json
  def destroy
    @product_vendor = ProductVendor.find(params[:id])
    @product_vendor.destroy

    respond_to do |format|
      format.html { redirect_to product_vendors_url }
      format.json { head :ok }
    end
  end
end
