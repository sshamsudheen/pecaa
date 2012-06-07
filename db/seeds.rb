# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Role.delete_all
User.delete_all

role = Role.create(:name=>"SuperAdmin",:display_name=>"System Administrator")
role2 = Role.create(:name=>"Administrator",:display_name=>"Administrator")
role3 = Role.create(:name=>"WebsiteBuilder",:display_name=>"Website Builder")
user_role = Role.create(:name=>"user",:display_name=>"Normal User")

(admin = User.create(:email=>"admin-pecaa@gmail.com",:username=>"admin-pecaa",:password=>"pecaa123")).roles = [role]
20.times do |i|
  u = User.create(:email=>"test#{i}@gmail.com",:username=>"test#{i}", :password=>"test#{i}")
  u.roles = [user_role]
end

site= Site.create(:name=>"Test", :description=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
                                  Duis sodales pulvinar felis ut placerat. Sed nisi sem, tristique ac suscipit eget,
                                  consequat nec mauris. Nam non tellus ante, aliquet euismod lacus. Sed rutrum justo 
                                  ac orci molestie nec venenatis purus vehicula. Quisque sodales diam in turpis semper sodales. 
                                  Integer condimentum ornare tempus. Nam odio neque, imperdiet ut adipiscing a, interdum in turpis. 
                                  Donec sollicitudin nulla nec lorem convallis vitae commodo nisl ornare. Pellentesque in scelerisque turpis.",
                                  :created_by => admin, 
                                  :is_active => true, 
                                  :title=>'Test')
                                  
SiteLink.create(:name=>"Home", :description=>'Some text',:created_by => admin, :is_active => true, :title=>'Home', :target=>"www.google.com", :site_id=>site)
SiteLink.create(:name=>"About Us", :description=>'Some text',:created_by => admin, :is_active => true, :title=>'About Us', :target=>"www.google.com", :site_id=>site)

authorize_net = PaymentGateway.create(:name => 'Authorize.net')
paypal = PaymentGateway.create(:name => 'Pay Pal')
google_checkout = PaymentGateway.create(:name => 'Google Checkout')
no_payment = PaymentGateway.create(:name => 'No Payment')

authorize_net.payment_gateway_attributes.create(:name => 'username')
authorize_net.payment_gateway_attributes.create(:name => 'password')

paypal.payment_gateway_attributes.create(:name => 'username')
paypal.payment_gateway_attributes.create(:name => 'password')
paypal.payment_gateway_attributes.create(:name => 'payment_method')

google_checkout.payment_gateway_attributes.create(:name => 'username')
google_checkout.payment_gateway_attributes.create(:name => 'password')

no_payment.payment_gateway_attributes.create(:name => 'friendly_name')

CreditCardType.create(:name => 'MasterCard')
CreditCardType.create(:name => 'Visa')
CreditCardType.create(:name => 'Discover')
CreditCardType.create(:name => 'American Express')


striketron = TaxGateway.create(:name => 'Striketron')
custom_tax = TaxGateway.create(:name => 'Custom Tax Rates')

striketron.tax_gateway_attributes.create(:name => 'username')
striketron.tax_gateway_attributes.create(:name => 'password')

custom_tax.tax_gateway_attributes.create(:name => 'location')
custom_tax.tax_gateway_attributes.create(:name => 'type')
custom_tax.tax_gateway_attributes.create(:name => 'tax_rate')


ups = ShippingGateway.create(:name => 'ups')
usps = ShippingGateway.create(:name => 'usps')
fedex = ShippingGateway.create(:name => 'fedex')

ups.shipping_gateway_attributes.create(:name => 'xml_access_key')
ups.shipping_gateway_attributes.create(:name => 'shipper')
ups.shipping_gateway_attributes.create(:name => 'username')
ups.shipping_gateway_attributes.create(:name => 'password')
ups.shipping_gateway_attributes.create(:name => 'modify_rate')
ups.shipping_gateway_attributes.create(:name => 'modifier_type')
shipping_gateway_attributes = ups.shipping_gateway_attributes.create(:name => 'service_type')
shipping_gateway_attributes.children.create(:name => 'ups_type_1')
shipping_gateway_attributes.children.create(:name => 'ups_type_2')
shipping_gateway_attributes.children.create(:name => 'ups_type_3')
shipping_gateway_attributes.children.create(:name => 'ups_type_4')
shipping_gateway_attributes.children.create(:name => 'ups_type_5')
shipping_gateway_attributes.children.create(:name => 'ups_type_6')
shipping_gateway_attributes.children.create(:name => 'ups_type_7')
shipping_gateway_attributes.children.create(:name => 'ups_type_8')
shipping_gateway_attributes.children.create(:name => 'ups_type_9')
shipping_gateway_attributes.children.create(:name => 'ups_type_10')
shipping_gateway_attributes.children.create(:name => 'ups_type_11')
shipping_gateway_attributes.children.create(:name => 'ups_type_12')

usps.shipping_gateway_attributes.create(:name => 'username')
usps.shipping_gateway_attributes.create(:name => 'password')
usps.shipping_gateway_attributes.create(:name => 'modify_rate')
usps.shipping_gateway_attributes.create(:name => 'modifier_type')

shipping_gateway_attributes = usps.shipping_gateway_attributes.create(:name => 'service_type')
shipping_gateway_attributes.children.create(:name => 'usps_type_1')
shipping_gateway_attributes.children.create(:name => 'usps_type_2')
shipping_gateway_attributes.children.create(:name => 'usps_type_3')
shipping_gateway_attributes.children.create(:name => 'usps_type_4')
shipping_gateway_attributes.children.create(:name => 'usps_type_5')
shipping_gateway_attributes.children.create(:name => 'usps_type_6')
shipping_gateway_attributes.children.create(:name => 'usps_type_7')
shipping_gateway_attributes.children.create(:name => 'usps_type_8')
shipping_gateway_attributes.children.create(:name => 'usps_type_9')
shipping_gateway_attributes.children.create(:name => 'usps_type_10')
shipping_gateway_attributes.children.create(:name => 'usps_type_11')
shipping_gateway_attributes.children.create(:name => 'usps_type_12')

fedex.shipping_gateway_attributes.create(:name => 'shipper')
fedex.shipping_gateway_attributes.create(:name => 'username')
fedex.shipping_gateway_attributes.create(:name => 'password')
fedex.shipping_gateway_attributes.create(:name => 'modify_rate')
fedex.shipping_gateway_attributes.create(:name => 'modifier_type')

shipping_gateway_attributes = fedex.shipping_gateway_attributes.create(:name => 'service_type')
shipping_gateway_attributes.children.create(:name => 'fedex_type_1')
shipping_gateway_attributes.children.create(:name => 'fedex_type_2')
shipping_gateway_attributes.children.create(:name => 'fedex_type_3')
shipping_gateway_attributes.children.create(:name => 'fedex_type_4')
shipping_gateway_attributes.children.create(:name => 'fedex_type_5')
shipping_gateway_attributes.children.create(:name => 'fedex_type_6')


ModifierType.create(:name => '%')
ModifierType.create(:name => '$')

20.times.each do 
  Review.create(:user_id=>User.first,:product_id => Product.first,:approved=>true,:description=>"over all i thought that over all i thought that over all i thought that over all i thought thatover all i thought that over all i thought thatover all i thought that over all i thought thatover all i thought that over all i thought thatover all i thought that over all i thought thatover all i thought that over all i thought thatover all i thought that over all i thought that")
end


custom_shipping = ShippingGateway.create(:name => 'custom_shipping')
custom_shipping.shipping_gateway_attributes.create(:name => 'name')
custom_shipping.shipping_gateway_attributes.create(:name => 'display_name')
custom_shipping.shipping_gateway_attributes.create(:name => 'modifier_type')
custom_shipping.shipping_gateway_attributes.create(:name => 'is_enable')

CustomShippingMethod.create(:name => 'flat_rate')
CustomShippingMethod.create(:name => 'weight_rate')
#no_payment = ShippingGateway.create(:type => 'custom ')


# 5.times do |i|
#   Theme.create(:name=>"theme#{i}", :theme_type=>"Free", :created_by=>admin)
# end
