class ContentLibrariesController < ApplicationController

  before_filter :setup
  layout 'pecaa_application'
  # GET /content_libraries
  # GET /content_libraries.json
  def index
    session[:site_page_id] =nil
	@users = User.all()
    @content_libraries = ContentLibrary.order("created_at desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @content_libraries }
    end
  end

  # GET /content_libraries/1
  # GET /content_libraries/1.json
  def show
    @content_library = ContentLibrary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @content_library }
    end
  end

  # GET /content_libraries/new
  # GET /content_libraries/new.json
  def new
    @content_library = ContentLibrary.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @content_library }
    end
  end

  # GET /content_libraries/1/edit
  def edit
    @content_library = ContentLibrary.find(params[:id])
  end

  # POST /content_libraries
  # POST /content_libraries.json
  def create
    @content_library = ContentLibrary.new(params[:content_library])

    respond_to do |format|
      if @content_library.save
        format.html { redirect_to @content_library, :notice => 'Content library was successfully created.' }
        format.json { render :json => @content_library, :status => :created, :location => @content_library }
      else
        format.html { render :action => "new" }
        format.json { render :json => @content_library.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /content_libraries/1
  # PUT /content_libraries/1.json
  def update
    @content_library = ContentLibrary.find(params[:id])

    respond_to do |format|
      if @content_library.update_attributes(params[:content_library])
        format.html { redirect_to @content_library, :notice => 'Content library was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @content_library.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /content_libraries/1
  # DELETE /content_libraries/1.json
  def destroy
    @content_library = ContentLibrary.find(params[:id])
    @content_library.destroy

    respond_to do |format|
      format.html { redirect_to content_libraries_url }
      format.json { head :ok }
    end
  end
  
  def search
    @text = Text.new()
    @misc = Misc.new()
    @site = Site.find(params[:site_id]) rescue nil
    #@site_page = SitePage.find(params[:site_page_id])
    #session[:site_page_id] = @site_page.id
    #@address = Address.find_by_site_id(params[:site_id])
    #@content_libraries = ContentLibrary.search(params[:search]).page(params[:page]).per(12)
	#@content_libraries = ContentLibrary.search(params[:search])
    #respond_to do |format|
     # format.html { render :action => "search",:layout=>"site" }
      #format.json { head :ok }
    #end
	@users = User.all()
	session[:site_page_id] =nil
    #@content_libraries = ContentLibrary.search(params[:search])
	@name = params[:name];
	@type = params[:source_type]; 
	@added_by = params[:added_by]; 
	query_text = "name LIKE '%#{@name}%'"	
	if @type!=''
		query_text = query_text + " and source_type =  '#{@type}'"
	end
	if @added_by!=''
		query_text = query_text + " and added_by =  '#{@added_by}'"
	end
	#Rails.logger.debug(query_text)
	@content_libraries = ContentLibrary.where(query_text)
    respond_to do |format|
      format.html # index.html.erb	 
      format.json { render :json => @content_libraries }
    end
  end
  
  protected

  def setup
    @site = Site.find_by_id(session[:site_id]) || Site.new
  end
  
end
