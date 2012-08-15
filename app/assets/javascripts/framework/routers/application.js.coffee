class RESocialBuilder.Routers.Application extends Backbone.Router
  routes:
    '': 'listings'
    'listings': 'listings'
    'blog': 'blog'
    'blog/:id': 'blog'

  # Load the system up
  initialize: ->
    # alert "System has loaded"
    

  listings: ->

    # Insert Search Form
    # SearchView = new RESocialBuilder.Views.Search


    # Insert the listings
    Listings = new RESocialBuilder.Views.Listings
    $('#content').html(Listings.render().el)



    # feedView = new RESocialBuilder.Views.ListingsFeed
    # $('.listings_feed').html(feedView.render().el)