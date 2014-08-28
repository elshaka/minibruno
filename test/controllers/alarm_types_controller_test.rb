require 'test_helper'

class AlarmTypesControllerTest < ActionController::TestCase
  setup do
    @alarm_type = alarm_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alarm_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alarm_type" do
    assert_difference('AlarmType.count') do
      post :create, alarm_type: { description: @alarm_type.description }
    end

    assert_redirected_to alarm_type_path(assigns(:alarm_type))
  end

  test "should show alarm_type" do
    get :show, id: @alarm_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alarm_type
    assert_response :success
  end

  test "should update alarm_type" do
    patch :update, id: @alarm_type, alarm_type: { description: @alarm_type.description }
    assert_redirected_to alarm_type_path(assigns(:alarm_type))
  end

  test "should destroy alarm_type" do
    assert_difference('AlarmType.count', -1) do
      delete :destroy, id: @alarm_type
    end

    assert_redirected_to alarm_types_path
  end
end
