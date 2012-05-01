module SitesHelper
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to(name, "#", :class=>"remove_fields")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, [new_object], :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    button_to_function('', ("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), :class=>"btnAddContact")
  end
  
  # def link_to_add_fields(name, f, association)
  #     new_object = f.object.class.reflect_on_association(association).klass.new
  #     fields = f.fields_for(association, [new_object], :index => "new_#{association}") do |builder|
  #       render(association.to_s.singularize + "_fields", :f => f, :poll_answer => new_object)
  #     end
  #     #     button_to_function('', ("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), :class=>"btnAddContact")
  # 
  #   end
  # 
  
  # def link_to_add_fields(name, f, association)
  #     new_object = f.object.class.reflect_on_association(association).klass.new
  #       fields = f.fields_for(association, :child_index => "new") do |builder|
  #               render(association.to_s.singularize + "_fields", :f => builder)
  #     end
  #     button_to_function('', ("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), :class=>"btnAddContact")
  #   end
  #
  
  def get_the_styles(site)
    ret = "<style>\n"
    if st = site.site_style
      ret +=  "body{color:##{st.text_style[:text_color]}}\n"
      ret +=  "div.box{width:70%; text-align:center; border-width: #{st.block_style[:border_width]}; border-radius: #{st.block_style[:border_radius]}; border-color: #{st.block_style[:block_color]};}"
      ret +=  "div.box{opacity: #{opacity_val(st.block_style[:block_opacity])};}"
      ret +=  "div.box{-moz-box-shadow: #{st.block_style[:box_shadow]}; -webkit-box-shadow: #{st.block_style[:box_shadow]}; box-shadow: #{st.block_style[:box_shadow]};}\n"
      ret +=  "H1 {font:normal 16px Arial, Helvetica, sans-serif; text-shadow: #{st.text_style[:text_shadow]} #ff0000;}\n"
    end
    ret += "</style>"
    ret.html_safe
  end
  
  def shadow_direction
    {:topLeft => "-3px -3px",
    :topCenter => "0px -3px",
    :topRight => "3px -3px",
    :middleLeft => "-3px 0",
    :middleCenter => "0px 0px",
    :middleRight => "3px 0px",
    :bottomLeft => "-3px 3px",
    :bottomMiddle => "0px 3px",
    :bottomRight => "3px 3px"}
  end
  
  def opacity_val(k)
    (k.to_i > 0) ? k.to_f/100 : 1
  end
  
end