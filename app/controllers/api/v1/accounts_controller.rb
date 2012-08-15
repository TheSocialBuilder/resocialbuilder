class Api::V1::AccountsController < Api::ApiController
  respond_to :json
  def index
    @account = current_profile
    respond_with @account
  end
  
end
