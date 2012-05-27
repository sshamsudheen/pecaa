require 'test_helper'

class TryItImagesControllerTest < ActionController::TestCase
  setup do
    @try_it_image = try_it_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:try_it_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create try_it_image" do
    assert_difference('TryItImage.count') do
      post :create, try_it_image: @try_it_image.attributes
    end

    assert_redirected_to try_it_image_path(assigns(:try_it_image))
  end

  test "should show try_it_image" do
    get :show, id: @try_it_image.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @try_it_image.to_param
    assert_response :success
  end

  test "should update try_it_image" do
    put :update, id: @try_it_image.to_param, try_it_image: @try_it_image.attributes
    assert_redirected_to try_it_image_path(assigns(:try_it_image))
  end

  test "should destroy try_it_image" do
    assert_difference('TryItImage.count', -1) do
      delete :destroy, id: @try_it_image.to_param
    end

    assert_redirected_to try_it_images_path
  end
end
