class Profile::ProfileController < ApplicationController
  layout "profile"

  before_filter :set_from_paths
  # before_filter :log_user_path


  # before_filter :authenticate_subdomain!

  def index
    @page = current_profile.pages.where(:page_type => 3).first
    # render "templates/template_1/index"
  end
  
  def listings
    @listings = Listing.paginate(:page => params[:page], :per_page => 15)
    
    # respond_to do |format|
    #   format.html { render "templates/template_1/listings" }
    #   format.js { render "templates/template_1/listings" }
    # end
  end
  
  def listing
    @listing = Listing.find_by(:mls_list_id => params[:mls_list_id])
    # render "templates/template_1/single_listing"
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
