class TextsController < ApplicationController
  layout 'pecaa_application', :except => [:new, :edit, :show]
#  uses_tiny_mce # :options => {
#    :width => "98%",
#    :height => "50%",
#    :theme_advanced_toolbar_location => "top"
#  }, :only => [:new]
  # GET /texts
  # GET /texts.json
  def index
    @texts = Text.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @texts }
    end
  end

  # GET /texts/1
  # GET /texts/1.json
  def show
    @text = Text.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @text }
    end
  end

  # GET /texts/new
  # GET /texts/new.json
  def new
    @text = Text.new

#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render :json => @text }
#    end
  end

  # GET /texts/1/edit
  def edit
    @text = Text.find(params[:id])
  end

  # POST /texts
  # POST /texts.json
  
  def create
    
    @text = Text.new(params[:text])
    @text.user_id = current_user
    @site  = Site.find(params[:site_id])
    @site_page = SitePage.find(params[:site_page_id]) 
    Text.transaction do
      if @text.save
        content_lib = ContentLibrary.create({:name => @text.text_block_name,
          :source_id => @text.id, :source_type => 'Text',
          :last_used => nil, :times_used => nil, :added_by => current_user.username})
        if @site
           ContentLibrariesSitePage.create(:site_id => @site.id,:content_library_id => content_lib.id,:site_page_id => @site_page.id )
           redirect_to "/sites/#{@site.id}/site_pages/#{@site_page.id}/content_libraries/search?search[source_type_equals]=Text&content_lib=#{content_lib.id}"
        else
          redirect_to content_libraries_path
        end
      else
        redirect_to content_libraries_path
#        respond_to do |format|
#          format.html  { render(:nothing => true)}
#        end
      end
    end
#  rescue
#    redirect_to content_libraries_path
  end

  # PUT /texts/1
  # PUT /texts/1.json
  def update
    @text = Text.find(params[:id])
    params[:text].merge!({:user_id => current_user})
    if @text.update_attributes(params[:text])
      content_library = ContentLibrary.find_by_source_id(@text.id)
      content_library.update_attributes({:name => @text.text_block_name,
          :last_used => nil, :times_used => nil, :added_by => current_user.username})
      redirect_to content_libraries_path
      else
        redirect_to content_libraries_path
#        respond_to do |format|
#          format.html  { render(:nothing => true)}
#        end
    end
  rescue
    redirect_to content_libraries_path
  end

  # DELETE /texts/1
  # DELETE /texts/1.json
  def destroy
    @text = Text.find(params[:id])
    @text.destroy

    respond_to do |format|
      format.html { redirect_to texts_url }
      format.json { head :ok }
    end
  end
end
