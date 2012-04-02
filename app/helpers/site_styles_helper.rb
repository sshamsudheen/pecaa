module SiteStylesHelper
  def check_theme_status(theme, site)
    if st = site.site_style && (st.theme_id == theme.id) 
      ["Edit", 'btnEdit']
    elsif(theme.price == 0.0)
      ["Apply", 'btnApply']
    else
      ["Purchase", 'btnPurchase']
    end
  end
end
