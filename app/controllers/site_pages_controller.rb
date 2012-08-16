class SitePagesController < ApplicationController
  before_filter :setup
  layout 'site'  
  
  def index
    @site_pages = @site.site_pages.where('parent_id=0').order('list_order')
    #logger.info "site_pages #{@site_pages.inspect}"
  end
  
  def new
    @site_page = @site.site_pages.new
    if params[:type]=='page'
      render :page_form, :layout => false
    elsif params[:type]=='link'
      render :link_form, :layout => false
    end
  end
  
  def create
    @site_page = SitePage.new(params[:site_page])
    @site_page.site = @site
    @site_page.created_by = current_user
    if @site_page.save
      flash[:notice] = "#{@site_page.category} was successfully saved"
    else
      flash[:notice] = "Saving #{@site_page.category} was unsuccessful"
    end
    @site_pages = @site.site_pages
    render :index
  end
  
  def update
    @site_page = SitePage.find(params[:id])
    if params[:site_page][:is_home_page]
      @site.site_pages.update_all(:is_home_page => false)
    end
    if @site_page.update_attributes(params[:site_page])
      flash[:notice] = "#{@site_page.category} was successfully saved"
    else
      flash[:notice] = "Saving #{@site_page.category} was unsuccessful"
    end
    
    if request.xhr?
      render :nothing=> true
    else
      redirect_to site_site_pages_path(@site) 
    end
    
  end
  
  def copy_page
    @site_page = SitePage.find(params[:id]).dup
    if @site_page.save
      flash[:notice] = "#{@site_page.category} was successfully copied"
    else
      flash[:notice] = "Coping #{@site_page.category} was unsuccessful"
    end
    redirect_to site_site_pages_path(@site)
  end
  
  def seo_page
    @site_page = @site.site_pages.find(params[:id])
    render :layout=>false
  end
  
  def rename_page
    @site_page = @site.site_pages.find(params[:id])
    @site_page.name = params[:value]
    @site_page.save
    render :text => params[:value] || ''
  end
  
  
  def destroy
    @site_page = @site.site_pages.find(params[:id])
    @site_page.destroy
    redirect_to site_site_pages_path(@site)
  end

  def content_new
    @site_page = SitePage.find(params[:id])
    # parse the data from json
    new_clib = JSON.load(params[:data])
    # now create the db record :site_id=>@site.id,:site_page_id=>@site_page.id,
    _a_cl = @site_page.content_libraries_site_pages.create(:site_id=>params['site_id'],:content_library_id=>new_clib['content_lib_id'],:content_type=>new_clib['type'],:list_order=>new_clib['listorder'])
    #logger.info "_a_cl c-new>> #{_a_cl.inspect}"
    render json: _a_cl
  end

  def content_destroy
    if params[:clibspid] and params[:clibspid].to_i > 0
      _lib = ContentLibrariesSitePage.find(params[:clibspid])
      _data = {:status => 0}
      if _lib.destroy
        _data[:status] = 1
      end
    end
    render json: _data
  end

  def content_save
    @site_page = SitePage.find(params[:id])
    # now save each block with the resized/repositioned attribs if any
    params[:style_position].each_with_index { |i,x|
      # create/update the content-library-site-page
      _a_cl = @site_page.content_libraries_site_pages.find(i[0])
      _a_cl.position = i[1]
      _a_cl.list_order = params[:list_order][i[0]]
      if !params[:iwidth].nil? and !params[:iheight].nil?
        if params[:iwidth][i[0]] and params[:iheight][i[0]]
          _a_cl.width = params[:iwidth][i[0]]
          _a_cl.height = params[:iheight][i[0]]
        end
      end
      _a_cl.save!
      #logger.info "Image Crop>> #{params[:crop][i[0]]}, #{x}"
      if (_a_cl.content_type == 'Image' and params[:crop][i[0]] and (content = ContentLibrary.find(_a_cl.content_library_id)) rescue nil)
        content.source.update_attributes(params[:crop][i[0]].merge(:updated_at => Time.now))
      end
    }
    # saving the sorted order of the blocks
    #sorting = params[:sorting_position].split(',').collect{|el| el.split('_').last}.join(';')
    #@site_page.update_attributes(:conent_positioning => sorting)
    #redirect_to :back

    if params[:is_preview] == 'true'
      redirect_to preview_site_path(@site)
    else
      redirect_to choose_theme_site_site_styles_path(@site)
    end
  end

  def reorder
    # sql hash object
    sqlhash = {}
    # lambda that digs the child nodes and builds the sql
    _dig = lambda{|p,c|
      c.each_with_index { |i,x|
        cid = i['title'][/\d+/]
        sqlhash.merge!("#{cid}"=> {'list_order'=>x+1, 'parent_id'=>p})
        if i['children'].length > 0
          _dig.call(cid, i['children'])
        end
      }
    }
    logger.info "params-data>> #{params[:data]}"
    # building the sql from the JSON posted
    JSON.load(params[:data]).each_with_index { |i,x|
      iid = i[0]['title'][/\d+/]
      sqlhash.merge!("#{iid}"=> {'list_order'=>x+1, 'parent_id'=>0})
      if i[0]['children'].length > 0
       _dig.call(iid, i[0]['children'])
      end
    }
    # update current site pages with their orders
    if !sqlhash.empty?
      logger.info "re-ordering the site-pages sqlhash>> #{sqlhash.inspect}"
      SitePage.update(sqlhash.keys, sqlhash.values)
    end
    render :nothing=> true
  end

  def reorder_old
    if params[:porder]
      phash = {}
      params[:porder].split(',').each_with_index { |i,x|
        phash.merge!("#{i}"=> {'list_order'=>x+1})
      }
      # update current site pages with their orders
      SitePage.update(phash.keys, phash.values)
    end

    render :nothing=> true
  end
  
    
  protected

  def setup
    @site = Site.find(params[:site_id] || params[:id]) 
    @symbol = "Website_List"
  end
  

end