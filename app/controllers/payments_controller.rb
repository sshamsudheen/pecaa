class PaymentsController < ApplicationController
  before_filter :ensure_site_id
  before_filter :get_payment_gateway
  def index
    render :template => template_name
  end

  def show
    render :template => template_name
  end

  def enable
    site_payemnt_gateway = SitesPaymentGateway.find_or_initialize_by_site_id_and_payment_gateway_id(@site.id, @payment_gateway.id)
    site_payemnt_gateway.update_attributes!(:is_enable => !site_payemnt_gateway.is_enable)
    redirect_to site_payment_path(@site.id, @payment_gateway.id)
  end

  def update
    site_payment_gateway = SitesPaymentGateway.find_by_site_id_and_payment_gateway_id(@site.id, @payment_gateway.id)
    SitePaymentGatewayAttributeValue.transaction do
      begin
        params[:payment_gateway_attribute].each do |payment_attribute, payment_value|
          payment_gateway_attribute = @payment_gateway.payment_gateway_attributes.where(:name => payment_attribute).last
          site_payment_gateway_attribute_value = SitePaymentGatewayAttributeValue.find_or_initialize_by_site_payment_gateway_id_and_payment_gateway_attribute_id(site_payment_gateway.id, payment_gateway_attribute.id)
          site_payment_gateway_attribute_value.update_attributes(:site_payment_gateway_id =>site_payment_gateway.id, :payment_gateway_attribute_id => payment_gateway_attribute.id, :value => payment_value)
        end
        site_payment_gateway.credit_card_types = CreditCardType.where(:id => params[:credit_card_type][:id].values) rescue []

        site_payment_gateway.update_attributes(params[:site_payment_gateway])
        flash[:notice] = "Updated Successfully"
      rescue
        flash[:notice] = "Problem saving the gateway, please try again"
      end
    end
    render :template => template_name
  end

  private

  def get_payment_gateway
    @payment_gateway = PaymentGateway.where(:id => params[:id]).last
    @payment_gateway = PaymentGateway.first if @payment_gateway.blank?
    params[:id] = @payment_gateway.id 
    @site_payment_gateway = SitesPaymentGateway.find_or_initialize_by_site_id_and_payment_gateway_id(@site.id, @payment_gateway.id)
  end

  def template_name
    'payments/'+@payment_gateway.name.underscore.gsub(" ", "_").gsub(".", "_")+".html.erb"
  end

end
