class ShippingGatewayAttributeValue < ActiveRecord::Base
  belongs_to :sites_shipping_gateway
  belongs_to :shipping_gateway_attribute

  def self.create_or_update_site_payment_gateway_details(site_payment_gateway, params_hash)
    SitePaymentGatewayAttributeValue.transaction do
        params_hash[:shipping_gateway_attribute].each do |payment_attribute, payment_value|
          payment_gateway_attribute = site_payment_gateway.shipping_gateway.shipping_gateway_attributes.where(:name => payment_attribute).last
          site_payment_gateway_attribute_value = find_or_initialize_by_sites_shipping_gateway_id_and_shipping_gateway_attribute_id(site_payment_gateway.id, payment_gateway_attribute.id)
          site_payment_gateway_attribute_value.update_attributes(:sites_shipping_gateway_id =>site_payment_gateway.id,
                                                                 :shipping_gateway_attribute_id => payment_gateway_attribute.id,
                                                                 :value => payment_value)
        end
        service_type_ids = ShippingGatewayAttribute.where(:name => 'service_type').last.children.map(&:id)
        where(:shipping_gateway_attribute_id => service_type_ids, :sites_shipping_gateway_id => site_payment_gateway.id).delete_all if !params_hash[:service_type].blank?
        !params_hash[:service_type].blank? && params_hash[:service_type].each do |service_type, id|
          create(:sites_shipping_gateway_id => site_payment_gateway.id, :shipping_gateway_attribute_id => id, :value => true)
        end
          site_payment_gateway.update_attributes!(:is_test_mode => params_hash[:site_payment_gateway]['is_test_mode'])
        "Updated Successfully"
    end
  end
end
