class SiteStylesController < ApplicationController
  before_filter :setup
   layout 'site'
  
  def index

  end
  
  protected

  def setup
    @site = Site.find(params[:site_id] || params[:id])
  end
  
end
