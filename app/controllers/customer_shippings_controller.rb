class CustomerShippingsController < ApplicationController
  layout "sessions"
  def index
    @address = get_address
    @site_shipping_gateways = SitesShippingGateway.where(:site_id => params[:site_id], :is_enable => true)
    @site_shipping_gateways.each do |site_shipping_gateway|
      site_shipping_gateway.display_names
    end.flatten

    @site = Site.find params[:site_id]
    record = "shipping"
    @site.site_style.theme.get_files('templates')
    @content = @site.site_style.theme.read_file("#{record.downcase}.liquid", 'templates')
    @content_layout = @site.site_style.theme.read_file("layout.liquid", 'templates')

    @site_theme = get_files_to_load(@site.site_style.theme) if @site.site_style && @site.site_style.theme
    icontent = Liquid::Template.parse(@content).render("#{record.downcase}" => "","site" => @site, "address" => @address,
                                                       "site_shipping_gateways" => @site_shipping_gateways,
                                                       "selected_shipping" => session[:shipping_attribute_id])
    lcontent = Liquid::Template.parse(@content_layout).render("content_for_layout" => icontent, "site" => @site, "site_theme"=> @site_theme)
    render :text => lcontent
  end

  def new
    @site = Site.find params[:site_id]
    record = "billing"
    @order = @site.orders.new
    @order.contact_same = true
    @order.address_same = true
    @order.billing_method ||= @order.billing_methods.first
    @order.shipping_gateway_id = session[:shipping_attribute_id]
    @shipping_gateway_name = ShippingGatewayAttributeValue.find(session[:shipping_attribute_id].to_i).value
    @order.shipping_address = Address.find session[:shipping_address_id]
    @shipping_address = @order.shipping_address
    @order.billing_address  = @order.shipping_address.dup
    @order.credit_card = CreditCard.new
    cart_products = session[:cart].collect do |id, quantity|
      product = Product.find id
      product.price = product.price_with_quantity(quantity)
      product
    end
    @site.site_style.theme.get_files('templates')
    @content = @site.site_style.theme.read_file("#{record.downcase}.liquid", 'templates')
    @content_layout = @site.site_style.theme.read_file("layout.liquid", 'templates')
    @site_theme = get_files_to_load(@site.site_style.theme) if @site.site_style && @site.site_style.theme
    icontent = Liquid::Template.parse(@content).render("#{record.downcase}" => "","site" => @site, "order" => @order,
                                                       "cart_products" => cart_products,
                                                       "shipping_address" => @shipping_address, "selected_billing" => @order.billing_method,
                                                       "billing_address" => @order.billing_address, "shipping_gateway_name" => @shipping_gateway_name)
    lcontent = Liquid::Template.parse(@content_layout).render("content_for_layout" => icontent, "site" => @site, "site_theme"=> @site_theme)
    render :text => lcontent
  end

  def checkout
    @site = Site.find params[:site_id]
    @order = @site.orders.new
    @order.contact_same = params[:order][:contact_same]
    @order.address_same = params[:order][:address_same]
    @order.billing_method = params[:order][:billing_method]
    @order.shipping_gateway_id = session[:shipping_attribute_id]
    @shipping_address = Address.find session[:shipping_address_id]
    @order.shipping_address = @shipping_address
    if [@order.contact_same, @order.address_same].all?{|a| a == "1" }
      @order.billing_address = @order.shipping_address
    else
      @order.build_billing_address params[:order][:billing_address]
    end
    @order.build_credit_card params[:order][:credit_card]
    session[:cart].each do |product, quantity|
      @order.order_products.build(:product_id => product, :number_of_product => quantity)
    end
    if @order.save
      flash[:notice] = "Order saved successfully."
      redirect_to new_site_customer_shipping_path(@site)
    else
      flash[:alert] = "Order was not saved successfully."
      redirect_to new_site_customer_shipping_path(@site)
    end
  end

  def create
    address = get_address
    @site = Site.find params[:site_id]
    address.update_attributes(params[:address].merge(:site_id => @site.id))
    session[:shipping_attribute_id] = params[:shipping_gateway][:id]
    session[:shipping_address_id] = address.id()
    redirect_to new_site_customer_shipping_path(@site)
  end

  def get_address(options = {})
    if current_user
      address = Address.find_by_user_id(current_user.id)
      address = Address.new(options) if address.blank?
      address
    else
      Address.new(options)
    end
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
end
