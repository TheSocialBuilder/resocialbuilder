class Website::WebsiteController < ApplicationController
  layout "../templates/template_1/layout"

  before_filter :authenticate_subdomain!
  before_filter :setup

  def index    
    render "templates/template_1/index"
  end
  
  def listings
    @listings = Listing.paginate(:page => params[:page], :per_page => 15)
    
    respond_to do |format|
      format.html { render "templates/template_1/listings" }
      format.js { render "templates/template_1/listings" }
    end
  end
  
  def listing
    @listing = Listing.find_by(:mls_list_id => params[:mls_list_id])
    render "templates/template_1/single_listing"
  end
  
  def blogs
    @blogs = current_account.blogs.cache
    render "templates/template_1/blogs"
  end
  
  def page
    render "templates/template_1/page"
  end


  private
    def setup
      
      @featured_listings = current_account.featured_listings.split(', ') if current_account.featured_listings
      @listings = Listing.in(:mls_list_id => @featured_listings).limit(5).cache if current_account.featured_listings
      
      @blogs = current_account.blogs.limit(5).cache
      

      @widget_text = {:title => "Test title", :content => "Test content"}
      
    end    
    



end
