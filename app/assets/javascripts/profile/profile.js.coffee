jQuery ->
  
  $("select").select2()



  $("#slider_search_bedrooms").slider
    value: $("#search_beds").val()
    min: 1
    max: 5
    step: 1
    slide: (event, ui) ->
      $("#slider_search_bedrooms_label").html("Bedrooms: "+ui.value+"+")
      # $('.multiple_listings').isotope({ sortBy: 'bed'});
      $("#search_beds").val(ui.value)

  $("#slider_search_bedrooms_label").html("Bedrooms: "+$("#search_beds").val()+"+")


  $("#slider_search_bathrooms").slider
    value: $("#search_baths").val()
    min: 1
    max: 5
    step: 1
    slide: (event, ui) ->
      $("#slider_search_bathrooms_label").html("Bathrooms: "+ui.value+"+")
      $("#search_baths").val(ui.value)

  $("#slider_search_bathrooms_label").html("Bathrooms: "+$("#search_baths").val()+"+")


  $("#slider_search_price_range").slider
    range: true
    min: 25000
    max: 2000000
    step: 25000
    values: [$("#search_price_min").val(), $("#search_price_max").val()]
    slide: (event, ui) ->
      $("#slider_search_price_range_label").html("Price Range: $"+ui.values[ 0 ]+" - $"+ui.values[ 1 ])
      $("#search_price_min").val(ui.values[ 0 ])
      $("#search_price_max").val(ui.values[ 1 ])


  $("#slider_search_price_range_label").html("Price Range: $"+$("#search_price_min").val()+" - $"+$("#search_price_max").val())
  
  $('.featured_listings').cycle
    fx: 'fade'
    delay: -4000
    pager:  '.featured_listings_nav'

  $('.multiple_listings').isotope
    itemSelector: '.listing'


  $('.pagination').hide()
  
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href').match(/page=([0-9]+)/)[1]

      if url && $(window).scrollTop() > $(document).height() - $(window).height() - (100 * parseInt(url))
        $('.pagination').text("Fetching more listings...")
        $.getScript('/listings?page='+url)
        
    $(window).scroll()