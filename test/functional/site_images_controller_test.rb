require 'test_helper'

class SiteImagesControllerTest < ActionController::TestCase
  setup do
    @site_image = site_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:site_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create site_image" do
    assert_difference('SiteImage.count') do
      post :create, site_image: @site_image.attributes
    end

    assert_redirected_to site_image_path(assigns(:site_image))
  end

  test "should show site_image" do
    get :show, id: @site_image.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @site_image.to_param
    assert_response :success
  end

  test "should update site_image" do
    put :update, id: @site_image.to_param, site_image: @site_image.attributes
    assert_redirected_to site_image_path(assigns(:site_image))
  end

  test "should destroy site_image" do
    assert_difference('SiteImage.count', -1) do
      delete :destroy, id: @site_image.to_param
    end

    assert_redirected_to site_images_path
  end
end
