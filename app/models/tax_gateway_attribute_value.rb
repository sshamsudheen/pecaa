class TaxGatewayAttributeValue < ActiveRecord::Base
  acts_as_tree
  belongs_to :tax_gateway_attribute
  belongs_to :site

  module Location
    TYPE = ['country', 'state', 'zip']    
  end
end
