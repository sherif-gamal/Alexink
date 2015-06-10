require 'test_helper'

class RawMaterialsControllerTest < ActionController::TestCase
  setup do
    @raw_material = raw_materials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:raw_materials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create raw_material" do
    assert_difference('RawMaterial.count') do
      post :create, raw_material: { description: @raw_material.description, in_stock: @raw_material.in_stock, name: @raw_material.name, unit: @raw_material.unit }
    end

    assert_redirected_to raw_material_path(assigns(:raw_material))
  end

  test "should show raw_material" do
    get :show, id: @raw_material
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @raw_material
    assert_response :success
  end

  test "should update raw_material" do
    patch :update, id: @raw_material, raw_material: { description: @raw_material.description, in_stock: @raw_material.in_stock, name: @raw_material.name, unit: @raw_material.unit }
    assert_redirected_to raw_material_path(assigns(:raw_material))
  end

  test "should destroy raw_material" do
    assert_difference('RawMaterial.count', -1) do
      delete :destroy, id: @raw_material
    end

    assert_redirected_to raw_materials_path
  end
end
