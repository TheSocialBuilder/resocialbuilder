class Dashboard::TransactionsController < Dashboard::DashboardController
  
  before_filter :setup_menu

  def setup_menu
    gon.menu_active_accordian = 3
    gon.menu_active_link = 'transactions'
  end
  

  def index
    @transactions = current_account.transactions.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions }
    end
  end


  def show
    @transaction = current_account.transactions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction }
    end
  end


end
