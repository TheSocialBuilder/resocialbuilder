require 'test_helper'

class RealtorsControllerTest < ActionController::TestCase
  setup do
    @realtor = realtors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:realtors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create realtor" do
    assert_difference('Realtor.count') do
      post :create, realtor: { account_id: @realtor.account_id, email: @realtor.email, first_name: @realtor.first_name, last_name: @realtor.last_name, mls_agent_id: @realtor.mls_agent_id, password: @realtor.password, phone: @realtor.phone, time_zone: @realtor.time_zone }
    end

    assert_redirected_to realtor_path(assigns(:realtor))
  end

  test "should show realtor" do
    get :show, id: @realtor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @realtor
    assert_response :success
  end

  test "should update realtor" do
    put :update, id: @realtor, realtor: { account_id: @realtor.account_id, email: @realtor.email, first_name: @realtor.first_name, last_name: @realtor.last_name, mls_agent_id: @realtor.mls_agent_id, password: @realtor.password, phone: @realtor.phone, time_zone: @realtor.time_zone }
    assert_redirected_to realtor_path(assigns(:realtor))
  end

  test "should destroy realtor" do
    assert_difference('Realtor.count', -1) do
      delete :destroy, id: @realtor
    end

    assert_redirected_to realtors_path
  end
end
