require 'test_helper'

class ProductFiltersControllerTest < ActionController::TestCase
  setup do
    @product_filter = product_filters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_filters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_filter" do
    assert_difference('ProductFilter.count') do
      post :create, product_filter: @product_filter.attributes
    end

    assert_redirected_to product_filter_path(assigns(:product_filter))
  end

  test "should show product_filter" do
    get :show, id: @product_filter.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_filter.to_param
    assert_response :success
  end

  test "should update product_filter" do
    put :update, id: @product_filter.to_param, product_filter: @product_filter.attributes
    assert_redirected_to product_filter_path(assigns(:product_filter))
  end

  test "should destroy product_filter" do
    assert_difference('ProductFilter.count', -1) do
      delete :destroy, id: @product_filter.to_param
    end

    assert_redirected_to product_filters_path
  end
end
