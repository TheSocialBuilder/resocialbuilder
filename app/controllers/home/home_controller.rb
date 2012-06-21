

class Home::HomeController < ApplicationController
  layout "home"

  respond_to :html

  def index
    
    

  end

  
  def facebook
    
    
    # raise @graph.get_object("me").to_yaml
    
    # post_to_wall = @graph.put_wall_post("T your gay")
    #     raise post_to_wall.to_yaml
    #     
    #     search = @graph.search("time+supply supply", {:type => "post"})
    #     raise search.to_yaml
    likes = @graph.get_connections("me", "likes")
    raise likes.to_yaml
    profile = @graph.get_object("me")
    friends = @graph.get_connections("me", "friends")
    pages = @graph.get_connections("me", "accounts")
    # raise pages.to_yaml
    
    # page_token = @graph.get_page_access_token(142429665816884)
    # => access_token
    # (if you don't get access_token, you're missing the manage_pages permission)
    @page_graph = Koala::Facebook::API.new('AAAC9OZCtxDC4BAI3Wm40Snz8lxpxQ7ZATwZAIatwUeE72sxweKX1RvU2jDtRV9Utiv1luwGKOIOFzfsaHlb7SuwsGclT7hrnEeaqGYKJvvwsiEPK8bF')
    
    raise @page_graph.to_yaml
    
    
    raise friends.to_yaml
    raise profile.to_yaml
    
  end
  
  
end
