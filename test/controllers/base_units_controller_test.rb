require 'test_helper'

class BaseUnitsControllerTest < ActionController::TestCase
  setup do
    @base_unit = base_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:base_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create base_unit" do
    assert_difference('BaseUnit.count') do
      post :create, base_unit: { unit: @base_unit.unit }
    end

    assert_redirected_to base_unit_path(assigns(:base_unit))
  end

  test "should show base_unit" do
    get :show, id: @base_unit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @base_unit
    assert_response :success
  end

  test "should update base_unit" do
    patch :update, id: @base_unit, base_unit: { unit: @base_unit.unit }
    assert_redirected_to base_unit_path(assigns(:base_unit))
  end

  test "should destroy base_unit" do
    assert_difference('BaseUnit.count', -1) do
      delete :destroy, id: @base_unit
    end

    assert_redirected_to base_units_path
  end
end
