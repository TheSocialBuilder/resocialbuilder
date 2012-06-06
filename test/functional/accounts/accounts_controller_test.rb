require 'test_helper'

class Accounts::AccountsControllerTest < ActionController::TestCase
  setup do
    @accounts_account = accounts_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accounts_account" do
    assert_difference('Accounts::Account.count') do
      post :create, accounts_account: { mls_office_id: @accounts_account.mls_office_id, settings_search_max: @accounts_account.settings_search_max, settings_search_min: @accounts_account.settings_search_min, site_title: @accounts_account.site_title, subdomain: @accounts_account.subdomain, time_zone: @accounts_account.time_zone, title: @accounts_account.title }
    end

    assert_redirected_to accounts_account_path(assigns(:accounts_account))
  end

  test "should show accounts_account" do
    get :show, id: @accounts_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accounts_account
    assert_response :success
  end

  test "should update accounts_account" do
    put :update, id: @accounts_account, accounts_account: { mls_office_id: @accounts_account.mls_office_id, settings_search_max: @accounts_account.settings_search_max, settings_search_min: @accounts_account.settings_search_min, site_title: @accounts_account.site_title, subdomain: @accounts_account.subdomain, time_zone: @accounts_account.time_zone, title: @accounts_account.title }
    assert_redirected_to accounts_account_path(assigns(:accounts_account))
  end

  test "should destroy accounts_account" do
    assert_difference('Accounts::Account.count', -1) do
      delete :destroy, id: @accounts_account
    end

    assert_redirected_to accounts_accounts_path
  end
end
