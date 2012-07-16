class Dashboard::ListingsController < Dashboard::DashboardController

  before_filter :setup_menu

  def setup_menu
    gon.menu_active_accordian = 1
    gon.menu_active_link = 'listings'
  end

  def index

    @listings = Listing.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listings }
    end
  end


  def show
    @listing = Listing.find(params[:id])
    # raise @listing.to_json
    
    respond_to do |format|
      format.html 
      format.json { render json: @listing }
    end
  end

end
