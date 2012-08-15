class RESocialBuilder.Views.Listings extends Backbone.View
  # template: JST['listing/index']
  tagName: 'div'
  className: 'multiple_listings'

  events:
    'scroll window': 'detect_scroll'
    'change #search_location': 'test'

  options:
    per_page: 25
    page: 1
    limit: 10


  initialize: =>
    # _.bindAll(this, 'detect_scroll');
    
    
    
    @collection = new RESocialBuilder.Collections.Listings()
    @collection.fetch({data: {limit: @options.limit, page: @options.page, per_page: @options.per_page}})
    # @collection.parse()
    @collection.on('reset', @render, this)
    # @collection.on('add', @render, this)

    
    # 
    # $(@el).masonry
    #   itemSelector: '.listing'
    #   isAnimated: true


  render: =>
    
    $(window).scroll(@detect_scroll)

    
    # console.log @collection.length
    # @template()
    $(@el).html('')
    @collection.each(@renderListing)
    
    # $(@el).masonry( 'reloadItems' )
    # $('.multiple_listings').masonry
    # 
    # $(window).load ->
    #   
    #   $('.multiple_listings').masonry
    #     itemSelector: '.listing'
    #     isAnimated: true
    
    
    @

    
  renderListing: (listing) =>

    listingView = new RESocialBuilder.Views.Listing(model: listing)
    view = listingView.render().el
    $(@el).append(listingView.render().el)

  appendListing: (listing) =>
    
    listingView = new RESocialBuilder.Views.Listing(model: listing)
    view = listingView.render().el
    $(@el).append(view).fadeIn('slow').masonry('reload')

    
    
  detect_scroll: =>
    # alert "scroll"
    triggerPoint = 100

    if !@options.emptyListings && $(window).scrollTop() > $(document).height() - $(window).height() - triggerPoint
      # $('html, body').animate({scrollTop: ($(window).height() / 2)+'px'}, 800)
      @options.page += 1
      
      @collection.fetch
        add: true
        wait: true
        data: 
          page: @options.page
          limit: @options.limit
        success: (collection, response) =>
          if response.length != 0
            for listings in response          
              listing = @collection.get(listings.id)
              @appendListing(listing)
              @options.emptyListings = false
              $('.sticky').stickySidebar()
          else
            @options.emptyListings = true
            $(@el).append('<div style="position:absolute; bottom:25px; left:300px; "><center>No More Listings to Load</center></div>')
          
          
      
      
      
      
      # $(window).scrollTop($(document).height() - triggerPoint)
    
    
  test: =>
    alert "test"