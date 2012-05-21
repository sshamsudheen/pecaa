class TaxGateway < ActiveRecord::Base
  has_many :tax_gateway_attributes  
  has_one :site

  module Gateway
    CUSTOM = "Custom Tax Rates"
    EASY = "Striketron"
  end
end
