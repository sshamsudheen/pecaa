module ApplicationHelper

  def check_selected(sym)
     params[:controller] == sym ? 'class=select' : ''
  end
  
  def set_link(path, modelObj, other_id=nil)
    # modelObj ? (link_to "   ", "#{modelObj.new_record? ?  '#' : path}", :style => "display:block;") : ""
    modelObj ? modelObj.new_record? ? '#' : other_id ? eval("#{path} #{modelObj.id}, #{other_id}") : eval("#{path} #{modelObj.id}") : ''
  end
  
  def site_top_nav(sym)
    if sym == "siteInfo" 
      (params[:controller] == 'sites' && ['new', 'edit'].include?(params[:action])) ? ' active' :
      !@site.new_record? ? 'complete' : ''
    elsif sym == "pages"
      (params[:controller] == 'site_pages') ? 'active' :
       (!@site.new_record? && @site.site_pages != []) ? 'complete' : ''
    elsif sym == "content"
      (params[:controller] == 'content_libraries') ? 'active' :
      (!@site.new_record? && @site.site_pages != []) ? 'complete' : ''
    elsif sym == "theme"
      (params[:controller] == 'site_styles') ? 'active' :
      (!@site.new_record? && @site.site_style) ? 'complete' : ''
    elsif sym == "optional"
      (params[:controller] == 'sites' && params[:action] == 'optional') ? 'active' :
      (!@site.new_record? && @site.site_optional_detail) ? 'complete' : ''
    elsif sym == "users"
      (params[:controller]== 'site_users') ? 'active' :
      (!@site.new_record? && @site.site_users != []) ? 'complete' : ''
    elsif sym == "done"
      (params[:controller] == 'sites' and params[:action] == 'done') ? 'active' : ''
    end
  end
end
