module SiteStylesHelper
  def check_theme_status(theme, site)
    st = site.site_style
    if st && (st.theme_id == theme.id) 
      ["Edit", 'btnEdit']
    elsif(theme.price == 0.0)
      ["Apply", 'btnApply']
    else
      ["Purchase", 'btnPurchase']
    end
  end
end
