module PaymentsHelper
  def site_payment_gateway_test_mode
    @site_payment_gateway.is_test_mode ? ["on", "enable_is_test_mode", "1"] : ["off", "disable_is_test_mode", "0"]
  end
end
