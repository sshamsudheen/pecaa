namespace :orders do
  task :import_data => :environment do
    (1..20).to_a.each do |a|
      Order.create(:order_id => "123ASDx#{a}", 
                   :status => "complete", 
                   :pay_status => (a%2 == 0 ? "paid" : "unpaid"),
                   :ship_status => (a%2 == 0 ? "ready" : "pending"),
                   :customer_email => "sallysgs#{a}@gmail.com",
                   :billing => Billing.new(:type_of_card => (a%2 == 0 ? "MasterCard" : "VisaCard"),
                                           :card_number => "1232 23#{a}3 12#{a}2 232#{a}",
                                           :auth_code => "adsfds#{a}ere#{a}",
                                           :amount => "#{a}2#{a}",
                                           :billing_address => (BillingAddress.new(:nickname => "sallysgs",
                                                                                  :address_line1 => "Home Billing#{a}",
                                                                                  :address_line2 => "123#{a} W, #{a} th Avenue",
                                                                                  :city => "Omaha",
                                                                                  :state => "Nebrasha",
                                                                                  :zip => "#{a}232#{a}#{a}"))
                                          ),
                   :shipping_detial => ShippingDetial.new(:shipping_id => "ads#{a}f#{a}s#{a}d#{a}fds",
                                                          :shipping_gateway_id => (ShippingGateway.first.id rescue nil),
                                                          :cost => "1#{a}",
                                                          :tracking_id => "dfdsd#{a}asd#{a}",
                                                          :status => "shipped",
                                                          :shipping_address => (ShippingAddress.new(:nickname => "sallysgs",
                                                                                  :address_line1 => "Home Billing#{a}",
                                                                                  :address_line2 => "123#{a} W, #{a} th Avenue",
                                                                                  :city => "Omaha",
                                                                                  :state => "Nebrasha",
                                                                                  :zip => "#{a}232#{a}#{a}"))
                                                          )
                                                          )
    end
    
    Order.all.each do |order|
      order.order_products.create(:product_id=>Product.first.id,:number_of_product => 2)
    end
    Order.all.each do |order|
      order.order_products.create(:product_id=>Product.last.id,:number_of_product => 2)
    end
  end
end

