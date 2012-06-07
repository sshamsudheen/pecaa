class ShippingGatewayAttributeValue < ActiveRecord::Base
  belongs_to :sites_shipping_gateway
  belongs_to :shipping_gateway_attribute
  has_many :order_ranges
  belongs_to :custom_shipping_method
  acts_as_tree

  def self.create_or_update_site_payment_gateway_details(site_payment_gateway, params_hash)
    SitePaymentGatewayAttributeValue.transaction do
        parent_value = params_hash[:shipping_gateway_attribute][:name]
        payment_gateway_attribute = site_payment_gateway.shipping_gateway.shipping_gateway_attributes.where(:name => 'name').last
        site_payment_gateway_attribute_value = find_or_initialize_by_sites_shipping_gateway_id_and_shipping_gateway_attribute_id_and_value_and_custom_shipping_method_id(site_payment_gateway.id, payment_gateway_attribute.id, parent_value, params_hash[:method_id])
        site_payment_gateway_attribute_value.update_attributes(:sites_shipping_gateway_id =>site_payment_gateway.id,
                                                               :shipping_gateway_attribute_id => payment_gateway_attribute.id,
                                                               :value => parent_value)
        params_hash[:shipping_gateway_attribute].delete('name')
        parent_id = site_payment_gateway_attribute_value.id
        site_payment_gateway_attribute_value.order_ranges.destroy_all unless params_hash["order_range"].values.blank?
        params_hash["order_range"].values.each do |order_range|

          site_payment_gateway_attribute_value.order_ranges.create(order_range)
        end
        params_hash[:shipping_gateway_attribute].each do |payment_attribute, payment_value|
          payment_gateway_attribute = site_payment_gateway.shipping_gateway.shipping_gateway_attributes.where(:name => payment_attribute).last
          site_payment_gateway_attribute_value = find_or_initialize_by_sites_shipping_gateway_id_and_shipping_gateway_attribute_id_and_value_and_custom_shipping_method_id(site_payment_gateway.id, payment_gateway_attribute.id, payment_value, params_hash[:method_id])
          site_payment_gateway_attribute_value.update_attributes(:sites_shipping_gateway_id =>site_payment_gateway.id,
                                                                 :shipping_gateway_attribute_id => payment_gateway_attribute.id,
                                                                 :value => payment_value, :parent_id => parent_id)

        end
        service_type_ids = ShippingGatewayAttribute.where(:name => 'service_type').last.children.map(&:id)
        where(:shipping_gateway_attribute_id => service_type_ids, :sites_shipping_gateway_id => site_payment_gateway.id).delete_all if !params_hash[:service_type].blank?
        !params_hash[:service_type].blank? && params_hash[:service_type].each do |service_type, id|
          create(:sites_shipping_gateway_id => site_payment_gateway.id, :shipping_gateway_attribute_id => id, :value => true)
        end
#          site_payment_gateway.update_attributes!(:is_test_mode => params_hash[:site_payment_gateway]['is_test_mode'])

        "Updated Successfully"
    end
  end

  def self.delete_attribute_values(site_shipping_gateway, params_hash)
    parent_obj = find(params_hash[:attr_id])
    parent_obj.children.destroy
    parent_obj.destroy
    parent_obj.order_ranges.each {|order_range| order_range.destroy}
  end
end
