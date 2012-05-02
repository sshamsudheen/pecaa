require 'test_helper'

class ProductVendorsControllerTest < ActionController::TestCase
  setup do
    @product_vendor = product_vendors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_vendors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_vendor" do
    assert_difference('ProductVendor.count') do
      post :create, product_vendor: @product_vendor.attributes
    end

    assert_redirected_to product_vendor_path(assigns(:product_vendor))
  end

  test "should show product_vendor" do
    get :show, id: @product_vendor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_vendor.to_param
    assert_response :success
  end

  test "should update product_vendor" do
    put :update, id: @product_vendor.to_param, product_vendor: @product_vendor.attributes
    assert_redirected_to product_vendor_path(assigns(:product_vendor))
  end

  test "should destroy product_vendor" do
    assert_difference('ProductVendor.count', -1) do
      delete :destroy, id: @product_vendor.to_param
    end

    assert_redirected_to product_vendors_path
  end
end
