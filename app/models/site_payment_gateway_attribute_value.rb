class SitePaymentGatewayAttributeValue < ActiveRecord::Base
  belongs_to :sites_payment_gateway
  belongs_to :payment_gateway_attribute

  def self.create_or_update_site_payment_gateway_details(site_payment_gateway, params_hash)
    SitePaymentGatewayAttributeValue.transaction do
      begin
        params_hash[:payment_gateway_attribute].each do |payment_attribute, payment_value|
          payment_gateway_attribute = site_payment_gateway.payment_gateway.payment_gateway_attributes.where(:name => payment_attribute).last
          site_payment_gateway_attribute_value = SitePaymentGatewayAttributeValue.find_or_initialize_by_sites_payment_gateway_id_and_payment_gateway_attribute_id(site_payment_gateway.id, payment_gateway_attribute.id)
          site_payment_gateway_attribute_value.update_attributes(:sites_payment_gateway_id =>site_payment_gateway.id, :payment_gateway_attribute_id => payment_gateway_attribute.id, :value => payment_value)
        end
        site_payment_gateway.credit_card_types = CreditCardType.where(:id => params_hash[:credit_card_type][:id].values) rescue []

        site_payment_gateway.update_attributes(params_hash[:site_payment_gateway])
        "Updated Successfully"
      rescue
        "Problem saving the gateway, please try again"
      end
    end
  end
end
