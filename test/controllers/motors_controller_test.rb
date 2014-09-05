require 'test_helper'

class MotorsControllerTest < ActionController::TestCase
  setup do
    @motor = motors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:motors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create motor" do
    assert_difference('Motor.count') do
      post :create, motor: { name: @motor.name }
    end

    assert_redirected_to motor_path(assigns(:motor))
  end

  test "should show motor" do
    get :show, id: @motor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @motor
    assert_response :success
  end

  test "should update motor" do
    patch :update, id: @motor, motor: { name: @motor.name }
    assert_redirected_to motor_path(assigns(:motor))
  end

  test "should destroy motor" do
    assert_difference('Motor.count', -1) do
      delete :destroy, id: @motor
    end

    assert_redirected_to motors_path
  end
end
