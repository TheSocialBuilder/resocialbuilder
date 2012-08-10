class SessionsController < ApplicationController

  skip_before_filter :authenticate_user!
  respond_to :json, :html

  def index    
    @authentications = current_account.authentications if current_account.nil?
  end

  def create
    omniauth = request.env["omniauth.auth"]


    if session[:from] == 'user'

      user = User.from_omniauth(omniauth)
      session[:user_id] = user.id.to_s if user
      redirect_to session[:from_last_path]

    else

      account = Account.from_omniauth(omniauth)
      session[:account_id] = account.id.to_s if account
      redirect_to dashboard_path

    end

  end

  def logout
    reset_session
    redirect_to root_url
  end

end