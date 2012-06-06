require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  setup do
    @account = accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account" do
    assert_difference('Account.count') do
      post :create, account: { mls_office_id: @account.mls_office_id, settings_search_max: @account.settings_search_max, settings_search_min: @account.settings_search_min, site_title: @account.site_title, subdomain: @account.subdomain, time_zone: @account.time_zone, title: @account.title }
    end

    assert_redirected_to account_path(assigns(:account))
  end

  test "should show account" do
    get :show, id: @account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account
    assert_response :success
  end

  test "should update account" do
    put :update, id: @account, account: { mls_office_id: @account.mls_office_id, settings_search_max: @account.settings_search_max, settings_search_min: @account.settings_search_min, site_title: @account.site_title, subdomain: @account.subdomain, time_zone: @account.time_zone, title: @account.title }
    assert_redirected_to account_path(assigns(:account))
  end

  test "should destroy account" do
    assert_difference('Account.count', -1) do
      delete :destroy, id: @account
    end

    assert_redirected_to accounts_path
  end
end
