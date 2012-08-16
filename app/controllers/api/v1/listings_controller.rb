class Api::V1::ListingsController < Api::ApiController
  respond_to :json
  def index
    
    # params[:page] = 1 if params[:page].nil?
    # params[:limit] = 15 if params[:limit].nil?
    
    @listings = Listing.paginate(:page => params[:page], :per_page => params[:limit])

    respond_with @listings
  end

  def show
    @listing =  Listing.find(params[:id])
    respond_with @listing
  end

end
