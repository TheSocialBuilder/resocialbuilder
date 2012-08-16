class RESocialBuilder.Views.Listings extends Backbone.View
  # template: JST['listing/index']
  tagName: 'div'
  className: 'multiple_listings'

  events:
    'scroll window': 'detect_scroll'
    'change #search_location': 'test'

  options:
    emptyListings: false
    hold_up: false
    per_page: 25
    page: 1
    limit: 5
    total_entries: 0
    total_pages: 0
    current_page: 1
    entry_count: 0


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

    $(@el).html('<div class="multiple_listings"></div>')
    
    $('.multiple_listings').isotope
      itemSelector: '.listing'
    
    @collection.each(@appendListing)
    
    @

  appendListing: (listing) =>


    @options.current_page = listing.get('pagination').current_page
    @options.total_pages = listing.get('pagination').total_pages


    listingView = new RESocialBuilder.Views.Listing(model: listing)
    view = listingView.render().el

    $('.multiple_listings').isotope( 'insert', $(view)).delay(3000)
    
    
  detect_scroll: =>
    # alert "scroll"
    triggerPoint = 100


    if @options.current_page < @options.total_pages && $(window).scrollTop() > $(document).height() - $(window).height() - triggerPoint
      # $('html, body').animate({scrollTop: ($(window).height() / 2)+'px'}, 800)
      @options.page += 1
      
      @collection.fetch
        add: true
        data: 
          page: @options.page
          limit: @options.limit
        success: (collection, response) =>
          if response.length != 0
            # alert listings[0].get('pagination').total_pages
            # if listing[0].get('pagination').total_pages >= @options.page

            for listings in response          
              listing = @collection.get(listings.id)
              @appendListing(listing) 
              @options.emptyListings = false
              # $('.sticky').stickySidebar()
            # $(window).scrollTop()
          else
            # @options.page = 1
            @options.emptyListings = true
            $(@el).append('<div style="position:absolute; bottom:25px; left:300px; "><center>No More Listings to Load</center></div>')

          
          
      
      
      
      
      # $(window).scrollTop($(document).height() - triggerPoint)
    
    
  test: =>
    alert "test"