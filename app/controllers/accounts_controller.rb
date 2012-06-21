class AccountsController < ApplicationController
  layout "home"
  
  def new
    @account = Account.new
  end

  def create
    
    # Create the fresh builds on the things we need
    @account = Account.new(params[:account])
    @card = @account.cards.new(params[:account][:card])
    @realtor = @account.realtors.new(params[:account][:realtor])
    
    # 4242424242424242
    
    # Charge the card
    ActiveMerchant::Billing::Base.mode = :test
    
    gateway = ActiveMerchant::Billing::Base.gateway(:pay_junction).new(:login => 'TestMerchant',:password => 'password')
    credit_card = ActiveMerchant::Billing::CreditCard.new(params[:account][:card])
    response = gateway.purchase(3000, credit_card)
    
    # Store the transaction whether we have a good or bad so we can track whats going on with these
    @transaction = @account.transactions.new(
      :title => 'Monthly Subscription Fee', 
      :card_id => @card.id.to_s, 
      :realtor_id => @realtor.id.to_s, 
      :transaction_date => response.params['transaction_date'], 
      :transaction_action => response.params['transaction_action'], 
      :approval_code => response.params['approval_code'], 
      :response_code => response.params['response_code'], 
      :response_message => response.params['response_message'], 
      :transaction_id => response.params['transaction_id'], 
      :base_amount => response.params['base_amount'], 
      :message => response.message, 
      :success => response.success?,
      :authorization => response.authorization
    )
    @transaction.save
    @card.save
    
    # if response.success? == false
    #   redirect_to dashboard_path, error: response.message
    #   break
    # end
    
    
    
    # raise response.to_yaml
    
    # TODO this will be down the road but we need to check if they are signed in with facebook
    # omniauth = session[:omniauth] if session[:omniauth]
    # @account.apply_omniauth(omniauth) if omniauth
    

    
    # if @account.save and response.success?
    if @account.save
      
      # Save the realtor
      @realtor.save
      
      session[:account_id] = @account.id.to_s
      session[:realtor_id] = @realtor.id.to_s

      redirect_to dashboard_path, info: 'Account was successfully created.'
    
    end
    
    
  end
  
  def login
    
    if params[:account]
      # Find the account by email
      account = Account.where(email: params[:account][:email]).first
      
      respond_to do |format|
        if account && account.authenticate(params[:account][:password])
          session[:account_id] = account.id.to_s
          format.html { redirect_to dashboard_path, info: 'Welcome to your RE Social Builder Dashboard' }

        else
          format.html { render action: "login", alert: "Email or password is invalid" }
        end
      end

    end
    
    
  end

  # Log the user out
  def logout
    reset_session
    redirect_to login_path, notice: "You have been logged out"
  end
end
