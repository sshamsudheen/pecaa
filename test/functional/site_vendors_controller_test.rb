require 'test_helper'

class SiteVendorsControllerTest < ActionController::TestCase
  setup do
    @site_vendor = site_vendors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:site_vendors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create site_vendor" do
    assert_difference('SiteVendor.count') do
      post :create, site_vendor: @site_vendor.attributes
    end

    assert_redirected_to site_vendor_path(assigns(:site_vendor))
  end

  test "should show site_vendor" do
    get :show, id: @site_vendor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @site_vendor.to_param
    assert_response :success
  end

  test "should update site_vendor" do
    put :update, id: @site_vendor.to_param, site_vendor: @site_vendor.attributes
    assert_redirected_to site_vendor_path(assigns(:site_vendor))
  end

  test "should destroy site_vendor" do
    assert_difference('SiteVendor.count', -1) do
      delete :destroy, id: @site_vendor.to_param
    end

    assert_redirected_to site_vendors_path
  end
end
