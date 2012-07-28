module ApplicationHelper

  def check_selected(sym)
     params[:controller] == sym ? 'class=select' : ''
  end
  
  def check_active(cltr, atn, css_klass = 'active')
     (params[:controller] == cltr && params[:action] == atn) ? "class=#{css_klass}" : ""
  end
  
  
  def set_link(path, modelObj, other_id=nil)
    # modelObj ? (link_to "   ", "#{modelObj.new_record? ?  '#' : path}", :style => "display:block;") : ""
    modelObj ? modelObj.new_record? ? '#' : other_id ? eval("#{path} #{modelObj.id}, #{other_id}") : eval("#{path} #{modelObj.id}") : ''
  end
  
  def site_content_link(site)
    if site.new_record? 
       1 
    elsif (c = site.site_pages) != []
      c.first.id
    else
      1
    end
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
  
  def numbers_extract(txt)
    txt.split(';').map{|c| c.gsub(/[^0-9]/, '').to_i}
  end
  
  def positioning_points(rec)
    width = numbers_extract(rec.left_eye_position)[0] - numbers_extract(rec.right_eye_position)[0]
    top = (numbers_extract(rec.right_eye_position)[1] - 150)
    left = (numbers_extract(rec.right_eye_position)[0] - 75)
    ["left:#{left}px; top:#{top}px;", "#{width + 45}px"]
  end
  
  def hotspot_images
    Dir.new("#{Rails.root}/public/frames/").entries.map{|n| n if n.match('.png')}.compact rescue []
  end
  
  def liquidize(content)
    RedCloth.new(Liquid::Template.parse(content).render).to_html
  end

end
