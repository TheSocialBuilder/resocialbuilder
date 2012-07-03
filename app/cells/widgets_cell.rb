class WidgetsCell < Cell::Rails
  
  include ApplicationHelper

  
  # Get the users featured listings to show on the home page in a banner scroller
  def featured_listings
    @listings = Listing.limit(5).cache
    render
  end
  
  # Get Random listings
  def random_listings
    @listings = Listing.limit(5).cache
    render
  end
  
  # Facebook Like Box
  def facebook
    @settings_social_facebook = current_profile.settings_social_facebook
    render
  end

  # Twitter recent tweets
  def twitter
    @settings_social_twitter = current_profile.settings_social_twitter
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
  

  
end