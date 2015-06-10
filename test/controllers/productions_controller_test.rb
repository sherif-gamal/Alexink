require 'test_helper'

class ProductionsControllerTest < ActionController::TestCase
  setup do
    @production = productions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:productions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create production" do
    assert_difference('Production.count') do
      post :create, production: { quantity: @production.quantity, raw_material_id: @production.raw_material_id, user_name: @production.user_name }
    end

    assert_redirected_to production_path(assigns(:production))
  end

  test "should show production" do
    get :show, id: @production
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @production
    assert_response :success
  end

  test "should update production" do
    patch :update, id: @production, production: { quantity: @production.quantity, raw_material_id: @production.raw_material_id, user_name: @production.user_name }
    assert_redirected_to production_path(assigns(:production))
  end

  test "should destroy production" do
    assert_difference('Production.count', -1) do
      delete :destroy, id: @production
    end

    assert_redirected_to productions_path
  end
end
