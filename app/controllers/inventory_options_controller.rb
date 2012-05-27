class InventoryOptionsController < ApplicationController
  # GET /inventory_options
  # GET /inventory_options.json
  layout 'features'
  def index
    @inventory_options = InventoryOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_options }
    end
  end

  # GET /inventory_options/1
  # GET /inventory_options/1.json
  def show
    @inventory_option = InventoryOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_option }
    end
  end

  # GET /inventory_options/new
  # GET /inventory_options/new.json
  def new
    @inventory_option = InventoryOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_option }
    end
  end

  # GET /inventory_options/1/edit
  def edit
    @inventory_option = InventoryOption.find(params[:id])
  end

  # POST /inventory_options
  # POST /inventory_options.json
  def create
    @inventory_option = InventoryOption.new(params[:inventory_option])
    @inventory_option.site_id = params[:site_id]
    respond_to do |format|
      if @inventory_option.save
        format.html { redirect_to "/sites/#{params[:site_id]}/inventory_options", notice: 'Inventory option was successfully created.' }
        format.json { render json: @inventory_option, status: :created, location: @inventory_option }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_options/1
  # PUT /inventory_options/1.json
  def update
    @inventory_option = InventoryOption.find(params[:id])

    respond_to do |format|
      if @inventory_option.update_attributes(params[:inventory_option])
        format.html { redirect_to "/sites/#{params[:site_id]}/inventory_options", notice: 'Inventory option was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_options/1
  # DELETE /inventory_options/1.json
  def destroy
    @inventory_option = InventoryOption.find(params[:id])
    @inventory_option.destroy

    respond_to do |format|
      format.html { redirect_to inventory_options_url }
      format.json { head :ok }
    end
  end
end
