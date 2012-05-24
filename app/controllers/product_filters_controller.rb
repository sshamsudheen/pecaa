class ProductFiltersController < ApplicationController
  # GET /product_filters
  # GET /product_filters.json
  layout 'features'
  def index
    @product_filters = ProductFilter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_filters }
    end
  end

  # GET /product_filters/1
  # GET /product_filters/1.json
  def show
    @product_filter = ProductFilter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_filter }
    end
  end

  # GET /product_filters/new
  # GET /product_filters/new.json
  def new
    @product_filter = ProductFilter.new
    render :layout => false
  end

  # GET /product_filters/1/edit
  def edit
    @product_filter = ProductFilter.find(params[:id])
  end

  # POST /product_filters
  # POST /product_filters.json
  def create
    @product_filter = ProductFilter.new(params[:product_filter])

    respond_to do |format|
      if @product_filter.save
        format.html { redirect_to "/sites/#{params[:site_id]}/product_filters" }
        format.json { render json: @product_filter, status: :created, location: @product_filter }
      else
        format.html { render action: "new" }
        format.json { render json: @product_filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_filters/1
  # PUT /product_filters/1.json
  def update
    @product_filter = ProductFilter.find(params[:id])

    respond_to do |format|
      if @product_filter.update_attributes(params[:product_filter])
        format.html { redirect_to @product_filter, notice: 'Product filter was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_filters/1
  # DELETE /product_filters/1.json
  def destroy
    @product_filter = ProductFilter.find(params[:id])
    @product_filter.destroy

    respond_to do |format|
      format.html { redirect_to product_filters_url }
      format.json { head :ok }
    end
  end
  
  def update_status
    @product_filter = ProductFilter.first || ProductFilter.new
    @product_filter.site_id = params[:product_filtering] == 'true' ? 1 : 0
    @product_filter.save
    render :action => 'index'
  end
  
  def enable_status
    @product_filter = ProductFilter.find(params[:id])
    @product_filter.status = !@product_filter.status
    @product_filter.save
    redirect_to "/sites/#{params[:site_id]}/product_filters"
  end
  
  def rename_editable
    @site_page = ProductFilter.find(params[:id].split('div_').last)
    @site_page.friendly_name = params[:value]
    @site_page.save
    render :text => params[:value] || ''
  end  
end

