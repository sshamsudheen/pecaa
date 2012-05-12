require 'test_helper'

class SiteFeaturesControllerTest < ActionController::TestCase
  setup do
    @site_feature = site_features(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:site_features)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create site_feature" do
    assert_difference('SiteFeature.count') do
      post :create, site_feature: @site_feature.attributes
    end

    assert_redirected_to site_feature_path(assigns(:site_feature))
  end

  test "should show site_feature" do
    get :show, id: @site_feature.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @site_feature.to_param
    assert_response :success
  end

  test "should update site_feature" do
    put :update, id: @site_feature.to_param, site_feature: @site_feature.attributes
    assert_redirected_to site_feature_path(assigns(:site_feature))
  end

  test "should destroy site_feature" do
    assert_difference('SiteFeature.count', -1) do
      delete :destroy, id: @site_feature.to_param
    end

    assert_redirected_to site_features_path
  end
end
