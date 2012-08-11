class Profile::ProfileController < ApplicationController
  layout "profile"

  before_filter :set_from_paths
  before_filter :setup_search
  # before_filter :log_user_path


  # before_filter :authenticate_subdomain!

  def index
    @page = current_profile.pages.where(:page_type => 3).first


    # @json = Listing.all.to_gmaps4rails

    # render "templates/template_1/index"
  end

  def setup_search
    @search = Search.new
  end

  def search

    

    if params[:commit] == "Search"

      @search = Search.new(params[:search])
      @search.save

      session[:last_search_id] = @search.id.to_s


      @listings = Listing
      @listings = @listings.between(price: @search.price_min..@search.price_max).asc(:price)

      @listings = @listings.gt(beds: @search.beds) if @search.beds.present?
      @listings = @listings.gt(baths: @search.baths) if @search.baths.present?

      @listings = @listings.where("location.city" => @search.city) if @search.city.present?

      # raise @listings.to_json
      # raise @listings.count.to_s

      @listings = @listings.paginate(:page => params[:page], :per_page => 15)

    end

    respond_to do |format|
      format.html { render "listings" }
    end
  end
  
  def listings
    @listings = Listing.paginate(:page => params[:page], :per_page => 15)
    
    respond_to do |format|
      format.html { render "listings" }
      format.js { render "listings" }
    end
  end
  
  def listing
    @listing = Listing.find_by(:mls_list_id => params[:mls_list_id])
    # render "templates/template_1/single_listing"
  end
  
  def blog
    @blog = current_profile.blogs.find_by_slug(params[:id])
  end

  def blogs
    @blogs = current_profile.blogs.cache
    # render "templates/template_1/blogs"
  end
  
  def page
    @page = current_profile.pages.find_by_slug(params[:id])
  end


  def set_from_paths
    session[:from] = 'user'
    session[:from_last_path] = root_url
  end

  def log_user_path
    
  end
end
