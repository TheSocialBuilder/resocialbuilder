class AuthenticationsController < ApplicationController

  skip_before_filter :authenticate_user!
  respond_to :json, :html

  def index    
    @authentications = current_realtor.authentications if current_realtor.nil?
  end

  def create
    omniauth = request.env["omniauth.auth"]
    # raise omniauth.to_yaml
    realtor = Realtor.where("authentications.provider" => omniauth['provider'], "authentications.uid" => omniauth['uid']).first
    # raise omniauth.to_yaml
    if realtor
      # raise user.to_yaml
      session[:realtor_id] = realtor.id.to_s
      flash[:notice] = 'Signed In!'
      redirect_to dashboard_path
    elsif current_realtor
      realtor = Realtor.find(current_realtor.id)
      # raise user.to_yaml
      realtor.apply_omniauth(omniauth)
      realtor.save
      flash[:notice] = 'Welcome, you have now Signed In!'
      redirect_to dashboard_path
    else
      session[:omniauth] = omniauth.except('extra')
      flash[:notice] = "Realtor not found, please signup, or login. Authorization will be applied to new account"
      redirect_to register_path
    end
  end

  private

  def destroy
    @authentication = current_realtor.authentications.find(params[:id])
  end

end