class TaxGatewayAttribute < ActiveRecord::Base
  belongs_to :tax_gateway
  has_many :tax_gateway_attribute_values
end
