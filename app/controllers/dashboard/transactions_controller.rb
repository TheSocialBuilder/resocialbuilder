class Dashboard::TransactionsController < Dashboard::DashboardController
  
  add_breadcrumb "Transactions", :dashboard_transactions_path
  def index
    @transactions = current_account.transactions.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions }
    end
  end


  def show
    add_breadcrumb "Showing Transactions", dashboard_transaction_path
    @transaction = current_account.transactions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction }
    end
  end


end
