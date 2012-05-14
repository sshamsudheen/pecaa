class MiscsController < ApplicationController
  # GET /miscs
  # GET /miscs.json
  def index
    @miscs = Misc.all

    respond_to do |format|
      format.html# index.html.erb
      format.json { render json: @miscs }
    end
  end

  # GET /miscs/1
  # GET /miscs/1.json
  def show
    @misc = Misc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @misc }
    end
  end

  # GET /miscs/new
  # GET /miscs/new.json
  def new
    # temporary fix 
    @site = Site.find(params[:site_id])
    @site_page = SitePage.find(params[:site_page_id])
    @misc = Misc.new
    @address = Address.find_by_site_id(params[:site_id])
    respond_to do |format|
      format.html { render :layout => false}# new.html.erb
      format.json { render json: @misc }
    end
  end

  # GET /miscs/1/edit
  def edit
    @misc = Misc.find(params[:id])
  end

  # POST /miscs
  # POST /miscs.json
  def create
    @misc = Misc.new(params[:misc])
    @site  = Site.find(params[:site_id])
    @site_page = SitePage.find(params[:site_page_id]) 
    respond_to do |format|
      if @misc.save
        ContentLibrariesSitePage.create(:site_id => @site.id,:content_library_id => nil,:site_page_id => @site_page.id,:content_type=>"Misc" )
        redirect_to "/sites/#{@site.id}/site_pages/#{@site_page.id}/content_libraries/search?search[source_type_equals]=Misc"
      else
        format.html { render action: "new" }
        format.json { render json: @misc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /miscs/1
  # PUT /miscs/1.json
  def update
    @misc = Misc.find(params[:id])

    respond_to do |format|
      if @misc.update_attributes(params[:misc])
        format.html { redirect_to @misc, notice: 'Misc was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @misc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /miscs/1
  # DELETE /miscs/1.json
  def destroy
    @misc = Misc.find(params[:id])
    @misc.destroy

    respond_to do |format|
      format.html { redirect_to miscs_url }
      format.json { head :ok }
    end
  end
end
