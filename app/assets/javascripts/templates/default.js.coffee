$(window).load ->
  

  $('.pagination').hide()
  
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href').match(/page=([0-9]+)/)[1]
      
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - (100 * parseInt(url))
        $('.sticky').stickySidebar()
        $('.pagination').text("Fetching more listings...")
        $.getScript('/listings?page='+url)
        
    $(window).scroll()
  
  
  
  $('.featured_listings').cycle() if $('.featured_listings').length !=0
  
  $('.listings_scoll').cycle() if $('.listings_scoll').length !=0
  
  $('.multiple_listings').isotope
    itemSelector: '.listing'



    
  # $('.sticky').stickySidebar()
  
  $("#slider_search_bedrooms").slider
    value: 1
    min: 1
    max: 5
    step: 1
    slide: (event, ui) ->
      $("#slider_search_bedrooms_label").html("Bedrooms: "+ui.value)
      # $('.multiple_listings').isotope({ sortBy: 'bed'});

  $("#slider_search_bedrooms_label").html("Bedrooms: "+$("#slider_search_bedrooms").slider("value"))

  $("#slider_search_bathrooms").slider
    value: 1
    min: 1
    max: 5
    step: 1
    slide: (event, ui) ->
      $("#slider_search_bathrooms_label").html("Bathrooms: "+ui.value)

  $("#slider_search_bathrooms_label").html("Bathrooms: "+$("#slider_search_bathrooms").slider("value"))


  $("#slider_search_price_range").slider
    range: true
    min: 25000
    max: 2000000
    step: 25000
    values: [25000, 2000000]
    slide: (event, ui) ->
      $("#slider_search_price_range_label").html("Price Range: $"+ui.values[ 0 ]+" - $"+ui.values[ 1 ])


  $("#slider_search_price_range_label").html("Price Range: $"+$("#slider_search_price_range").slider( "values", 0)+" - $"+$("#slider_search_price_range").slider( "values", 1 ))
  
  

