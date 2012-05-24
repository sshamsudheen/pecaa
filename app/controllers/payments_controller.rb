class PaymentsController < ApplicationController
  before_filter :ensure_site_id
  before_filter :get_payment_gateway
  def index
    @site_payment_gateway = SitesPaymentGateway.find_or_initialize_by_site_id_and_payment_gateway_id(@site.id, @payment_gateway.id)
    render :template => template_name
  end

  def show
    @site_payment_gateway = SitesPaymentGateway.find_or_initialize_by_site_id_and_payment_gateway_id(@site.id, @payment_gateway.id)
    render :template => template_name
  end

  def enable
    site_payemnt_gateway = SitesPaymentGateway.find_or_initialize_by_site_id_and_payment_gateway_id(@site.id, @payment_gateway.id)
    site_payemnt_gateway.update_attributes!(:is_enable => !site_payemnt_gateway.is_enable)
    @site_payment_gateway = SitesPaymentGateway.find_or_initialize_by_site_id_and_payment_gateway_id(@site.id, @payment_gateway.id)
    redirect_to site_payment_path(@site.id, @payment_gateway.id)
  end

  def update
    site_payment_gateway = SitesPaymentGateway.find_by_site_id_and_payment_gateway_id(@site.id, @payment_gateway.id)
    flash[:notice] = SitePaymentGatewayAttributeValue.create_or_update_site_payment_gateway_details(site_payment_gateway, params)
    @site_payment_gateway = SitesPaymentGateway.find_or_initialize_by_site_id_and_payment_gateway_id(@site.id, @payment_gateway.id)
    render :template => template_name
  end

  private

  def get_payment_gateway
    @payment_gateway = PaymentGateway.where(:id => params[:id]).last
    @payment_gateway = PaymentGateway.first if @payment_gateway.blank?
    params[:id] = @payment_gateway.id
  end

  def template_name
    'payments/'+@payment_gateway.name.underscore.gsub(" ", "_").gsub(".", "_")+".html.erb"
  end

end
