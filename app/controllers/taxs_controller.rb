class TaxsController < ApplicationController
  before_filter :ensure_site_id, :get_tax_gateway
  layout 'payments'


  def index

  end

  def enable
    @site.update_attribute(:enable_tax, !@site.enable_tax)
    redirect_to :action => :index
  end

  def create        
    get_type_from_params
    parent_tax_attribute_id = TaxGatewayAttribute.find_by_name('location')
    parent_tax = TaxGatewayAttributeValue.create(:tax_gateway_attribute_id => parent_tax_attribute_id.id,
                                        :value => params['tax_gateway_attribute']['location'],
                                        :site_id => @site.id) if parent_tax_attribute_id
    params['tax_gateway_attribute'].delete('location')
    parent_tax_attribute_id && params['tax_gateway_attribute'].each do |key, value|
      tax_attribute = TaxGatewayAttribute.find_by_name(key)
      parent_tax.children.create(:tax_gateway_attribute_id => tax_attribute.id,
                                 :value                    => value, :site_id => @site.id) if tax_attribute
    end
    redirect_to :action => :index
  end

  def create_tax_gateway
    tax_gateway = TaxGateway.find(params[:tax_gateway_id])
    params['tax_gateway_attribute'].each do |attribute, value|
      tax_gateway_attribute = TaxGatewayAttribute.where(:name => attribute, :tax_gateway_id => tax_gateway.id).last
      tax_gateway_attribute_value = TaxGatewayAttributeValue.where(:tax_gateway_attribute_id => tax_gateway_attribute.id, :site_id => @site.id).last
      if tax_gateway_attribute_value
        tax_gateway_attribute_value.update_attributes(:value => value)  
      else
        TaxGatewayAttributeValue.create(:tax_gateway_attribute_id => tax_gateway_attribute.id, :site_id => @site.id, :value => value)
      end
    end
    redirect_to :action => :index
  end

  def enable_custom
    tax_gateway_attribute_value = TaxGatewayAttributeValue.find(params[:id])
    tax_gateway_attribute_value.update_attribute(:is_enable, !tax_gateway_attribute_value.is_enable)
    redirect_to :action => :index
  end

  def destroy
    tax_gateway_attribute = TaxGatewayAttributeValue.where("id = #{params[:id]} and parent_id is NULL").last
    if tax_gateway_attribute
      tax_gateway_attribute.children.destroy
      tax_gateway_attribute.destroy
    end
    redirect_to :action => :index
  end

  private

  def get_type_from_params
    tax_gateway_attribute = params['tax_gateway_attribute']
    if tax_gateway_attribute['location'] == 'country'
      params['tax_gateway_attribute']['type'] = tax_gateway_attribute['country_type']
    elsif tax_gateway_attribute['location'] == 'state'
      params['tax_gateway_attribute']['type'] = tax_gateway_attribute['state_type']
    elsif tax_gateway_attribute['location'] == 'zip'
      params['tax_gateway_attribute']['type'] = tax_gateway_attribute['zip_type']
    end
  end

  def get_tax_gateway
#    @tax_gateway = TaxGateway.find_by_id(params[:id])
#    @tax_gateway = TaxGateway.last if @tax_gateway.blank?
#    params[:id] = @tax_gateway.id
#    @site_tax_gateway = SitesTaxGateway.find_by_site_id(@site.id)
#    @custom_tax_payment = ((@tax_gateway.name == Gateway::CUSTOM) || @site_tax_gateway.blank?)
  end
end
