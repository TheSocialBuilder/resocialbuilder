class WidgetsCell < Cell::Rails
  
  include ApplicationHelper

  before_filter :setup_search

  def setup_search
    @search = Search.new
  end

  def search

    @search = Search.find(session[:last_search_id])
    

    @market = Market.find_by(:title => 'stgeorge')
    @listings = Listing.all

    # Build the list of cities
    @cities = Array.new
    @listings.each do |listing|
      @cities.push(listing.location.city) if listing.location.city
    end
    @cities.uniq!


    # Build the list of types
    @type = Array.new
    @listings.each do |listing|
      @type.push(listing.type) if listing.type
    end
    @type.uniq!

    
    render
  end

  def member_area
    @current_user = current_user
    render
  end
  
  
  # Get the users featured listings to show on the home page in a banner scroller
  def featured_listings
    @listings = Listing.limit(5)
    render
  end
  
  # Get Random listings
  def random_listings
    @listings = Listing.limit(5).cache
    render
  end
  
  # Facebook Like Box
  def facebook
    if current_profile.settings_social_facebook
      @settings_social_facebook = current_profile.settings_social_facebook
    else
      @settings_social_facebook = nil
    end
    render
  end

  # Twitter recent tweets
  def twitter

    if current_profile.settings_social_twitter
      @settings_social_twitter = current_profile.settings_social_twitter.gsub('https://twitter.com/', '').gsub('http://twitter.com/', '').gsub('https://www.twitter.com/', '').gsub('http://www.twitter.com/', '')
    else
      @settings_social_twitter = nil
    end
    

    render
  end

  # About the Realtor
  def about_realtor
    @current_profile = current_profile
    render
  end
  
  # Page
  def page(args)
    @title = args[:title]
    @content = args[:content]
    render
  end

  # Plain Text
  def text(args)
    @title = args[:title]
    @content = args[:content]
    render
  end


  # Users most recent blog posts
  def recent_blog_posts
    @blog_posts = current_profile.blogs.limit(5).cache
    render
  end


  # Newsletters
  def newsletter
    
    render
  end  

  # Maps
  def map
    @json = Listing.all.to_gmaps4rails
    render
  end
  

  
end