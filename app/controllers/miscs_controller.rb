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
  def create
    @misc = Misc.new(params[:misc])
    @site  = Site.find(params[:site_id])
    @site_page = SitePage.find(params[:site_page_id]) 

    if @misc.save
      ContentLibrariesSitePage.create(:site_id => @site.id,:content_library_id => nil,:site_page_id => @site_page.id,:content_type=>'Misc',:position=>(params[:misc_position].nil? ? params[:misc_position] : 'width: 500px;'),:misc_id=>@misc.id,:list_order=>(params[:list_order]?params[:list_order]:0))
      #redirect_to "/sites/#{@site.id}/site_pages/#{@site_page.id}/content_libraries/search?search[source_type_equals]=Misc"
    else
      render action: 'new'
    end

    redirect_to :back
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

  # GET /miscs/1/show_block
  # GET /miscs/1/show_block.json
  def show_block
    # temporary fix
    @site = Site.find(params[:site_id])
    @site_page = SitePage.find(params[:site_page_id])
    @misc = Misc.find(params[:id])
    @from_content = false
    spclib = ContentLibrariesSitePage.where("site_id=#{@site.id} AND site_page_id=#{@site_page.id} AND misc_id=#{@misc.id}")
    logger.info "misc.spclib: #{spclib.inspect}"
    @bloc_id=spclib[0].id
    @resizable_el_style = spclib.length > 0 ? spclib[0].position : 'top:0;left:0;'
    respond_to do |format|
      format.html { render :layout => false}# new.html.erb
      format.json { render json: @misc }
    end
  end
end
