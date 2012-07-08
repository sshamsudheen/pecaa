class CartsController < ApplicationController
  skip_before_filter :authorize_user, :authenticate_user!

  layout "cart"

  def index
    session[:cart] ||= {}
    @site = Site.find params[:site_id]
    record = "cart"
    @site.site_style.theme.get_files('templates')
    @content = @site.site_style.theme.read_file("#{record.downcase}.liquid", 'templates')
    @content_layout = @site.site_style.theme.read_file("layout.liquid", 'templates')

    @site_theme = get_files_to_load(@site.site_style.theme) if @site.site_style && @site.site_style.theme
    @session_cart = build_session(session[:cart])

    icontent = Liquid::Template.parse(@content).render("#{record.downcase}" => "","site" => @site, "session_cart" => @session_cart)
    lcontent = Liquid::Template.parse(@content_layout).render("content_for_layout" => icontent, "site" => @site, "site_theme"=> @site_theme, "session_cart" => build_session(session[:cart]))
    render :text => lcontent
  end

  def update
    @site = Site.find(params[:site_id])
    order_product = session[:cart].merge!(params[:id] => params[:quantity].to_i)
    flash[:notice] = 'Order was successfully updated.'
    redirect_to site_carts_path(@site)
  end

  def destroy
    @site = Site.find(params[:site_id])
    session[:cart].delete_if{|id,qua| id == params[:id] }
    flash[:notice] = 'Item was successfully removed.'
    redirect_to site_carts_path(@site)
  end

  def show
    session[:cart] ||= {}
    session[:cart].merge!(params[:id] => 1) unless session[:cart].keys.include?(params[:id])
    flash[:notice] = 'Item was successfully added to cart.'
    redirect_to site_carts_path(@site)
  end

  def get_files_to_load(theme)
    files = ""
    theme.get_files.each do |n|
      if Theme.check_file_type(n)
        case (n.split('.').last.downcase)
          when 'js'
            files += "<script type='text/javascript' src='#{theme.get_load_path}/#{n}'></script>"
          when 'css'
            files += "<link rel='stylesheet' href='#{theme.get_load_path}/#{n}' type='text/css'>"
        end
      end
    end
    files.blank? ? nil : files.html_safe
  end

  def build_session(session_cart)
    session_cart.collect do |id, quantity|
      product = Product.find(id)
      product.price = product.price_with_quantity(quantity)
      {product => quantity}
    end.compact
  end


end
