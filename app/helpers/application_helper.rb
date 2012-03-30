module ApplicationHelper

  def check_selected(sym)
     params[:controller] == sym ? 'class=select' : ''
  end
  
  def set_link(path, modelObj)
    # modelObj ? (link_to "   ", "#{modelObj.new_record? ?  '#' : path}", :style => "display:block;") : ""
    modelObj ? modelObj.new_record? ? '#' : eval("#{path} #{modelObj.id}") : ''
  end
  
end
