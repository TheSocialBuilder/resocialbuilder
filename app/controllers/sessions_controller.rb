class SessionsController < ApplicationController

  skip_before_filter :authenticate_user!
  respond_to :json, :html

  def index    
    @authentications = current_account.authentications if current_account.nil?
  end

  def create
    omniauth = request.env["omniauth.auth"]
    account = Account.from_omniauth(omniauth)
    
    session[:account_id] = account.id.to_s if account
    redirect_to dashboard_path
  end

end