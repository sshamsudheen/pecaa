class ShippingDetialsController < ApplicationController
  # GET /shipping_detials
  # GET /shipping_detials.json
  def index
    @shipping_detials = ShippingDetial.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shipping_detials }
    end
  end

  # GET /shipping_detials/1
  # GET /shipping_detials/1.json
  def show
    @shipping_detial = ShippingDetial.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shipping_detial }
    end
  end

  # GET /shipping_detials/new
  # GET /shipping_detials/new.json
  def new
    @shipping_detial = ShippingDetial.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shipping_detial }
    end
  end

  # GET /shipping_detials/1/edit
  def edit
    @shipping_detial = ShippingDetial.find(params[:id])
  end

  # POST /shipping_detials
  # POST /shipping_detials.json
  def create
    @shipping_detial = ShippingDetial.new(params[:shipping_detial])

    respond_to do |format|
      if @shipping_detial.save
        format.html { redirect_to @shipping_detial, notice: 'Shipping detial was successfully created.' }
        format.json { render json: @shipping_detial, status: :created, location: @shipping_detial }
      else
        format.html { render action: "new" }
        format.json { render json: @shipping_detial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shipping_detials/1
  # PUT /shipping_detials/1.json
  def update
    @shipping_detial = ShippingDetial.find(params[:id])

    respond_to do |format|
      if @shipping_detial.update_attributes(params[:shipping_detial])
        format.html { redirect_to @shipping_detial, notice: 'Shipping detial was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shipping_detial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipping_detials/1
  # DELETE /shipping_detials/1.json
  def destroy
    @shipping_detial = ShippingDetial.find(params[:id])
    @shipping_detial.destroy

    respond_to do |format|
      format.html { redirect_to shipping_detials_url }
      format.json { head :ok }
    end
  end
end
