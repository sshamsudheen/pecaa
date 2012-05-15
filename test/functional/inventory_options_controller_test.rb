require 'test_helper'

class InventoryOptionsControllerTest < ActionController::TestCase
  setup do
    @inventory_option = inventory_options(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_options)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_option" do
    assert_difference('InventoryOption.count') do
      post :create, inventory_option: @inventory_option.attributes
    end

    assert_redirected_to inventory_option_path(assigns(:inventory_option))
  end

  test "should show inventory_option" do
    get :show, id: @inventory_option.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_option.to_param
    assert_response :success
  end

  test "should update inventory_option" do
    put :update, id: @inventory_option.to_param, inventory_option: @inventory_option.attributes
    assert_redirected_to inventory_option_path(assigns(:inventory_option))
  end

  test "should destroy inventory_option" do
    assert_difference('InventoryOption.count', -1) do
      delete :destroy, id: @inventory_option.to_param
    end

    assert_redirected_to inventory_options_path
  end
end
