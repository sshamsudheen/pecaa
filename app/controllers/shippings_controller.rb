class ShippingsController < ApplicationController
  before_filter :ensure_site_id
  before_filter :get_shipping_gateway
  layout 'payments'

  def index

    render :template => template_name
  end

  def show    
    render :template => template_name
  end

  def enable
    @site_payment_gateway.update_attributes!(:is_enable => !@site_payment_gateway.is_enable)
    redirect_to site_shipping_path(@site.id, @payment_gateway.id)
  end

  def update
    site_payment_gateway = SitesShippingGateway.find_by_site_id_and_shipping_gateway_id(@site.id, @payment_gateway.id)
    flash[:notice] = ShippingGatewayAttributeValue.create_or_update_site_payment_gateway_details(site_payment_gateway, params)
    redirect_to site_shipping_path(@site.id, @payment_gateway.id)
  end

  def destroy_shipping
    site_payment_gateway = SitesShippingGateway.find_by_site_id_and_shipping_gateway_id(@site.id, @payment_gateway.id)
    if params[:range]
      OrderRange.destroy(params[:range])
    else
      flash[:notice] = ShippingGatewayAttributeValue.delete_attribute_values(site_payment_gateway, params)
    end
    redirect_to site_shipping_path(@site.id, @payment_gateway.id)
  end

  private

  def get_shipping_gateway
    @payment_gateway = ShippingGateway.where(:id => params[:id]).last
    @payment_gateway = ShippingGateway.first if @payment_gateway.blank?
    params[:id] = @payment_gateway.id
    @site_payment_gateway = SitesShippingGateway.find_or_initialize_by_site_id_and_shipping_gateway_id(@site.id, @payment_gateway.id)

  end

  def template_name
    'shippings/'+@payment_gateway.name.underscore.gsub(" ", "_").gsub(".", "_")+".html.erb"
  end
end
