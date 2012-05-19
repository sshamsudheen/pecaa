require 'test_helper'

class ShippingDetialsControllerTest < ActionController::TestCase
  setup do
    @shipping_detial = shipping_detials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shipping_detials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipping_detial" do
    assert_difference('ShippingDetial.count') do
      post :create, shipping_detial: @shipping_detial.attributes
    end

    assert_redirected_to shipping_detial_path(assigns(:shipping_detial))
  end

  test "should show shipping_detial" do
    get :show, id: @shipping_detial.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shipping_detial.to_param
    assert_response :success
  end

  test "should update shipping_detial" do
    put :update, id: @shipping_detial.to_param, shipping_detial: @shipping_detial.attributes
    assert_redirected_to shipping_detial_path(assigns(:shipping_detial))
  end

  test "should destroy shipping_detial" do
    assert_difference('ShippingDetial.count', -1) do
      delete :destroy, id: @shipping_detial.to_param
    end

    assert_redirected_to shipping_detials_path
  end
end
