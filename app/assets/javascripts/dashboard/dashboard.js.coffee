$(document).ready ->
  
  resb_sidebar.make()
  
  render = (term, data, type) -> 
    console.log term
    term
  select = (term, data, type) ->
    window.location.href = data.url

      
  $('.dashboard_search').soulmate {
    url:            'http://soulmate.lvh.me:3000/search'
    types:          RESocialBuilder.search_fields
    renderCallback: render
    selectCallback: select
    minQueryLength: 2
    maxResults:     5
  }
  
  $("ol.sortable").nestedSortable
    disableNesting: "no-nest"
    forcePlaceholderSize: true
    handle: "div"
    helper: "clone"
    items: "li"
    maxLevels: 3
    opacity: .6
    placeholder: "placeholder"
    revert: 250
    tabSize: 25
    tolerance: "pointer"
    toleranceElement: "> div"
    update: (event, ui) ->
      set = {set : JSON.stringify($('ol.sortable').nestedSortable('toHierarchy', {startDepthCount: 0}))}
      $.post("savesort", set)
      $('#output').html('<p id="flash_notice">Saved Successfully</p>')
      
  $(".select2").select2()



  lastWindowHeight = $(window).height()
  lastWindowWidth = $(window).width()
  
  $(window).on "debouncedresize", ->
    if $(window).height() isnt lastWindowHeight or $(window).width() isnt lastWindowWidth
      lastWindowHeight = $(window).height()
      lastWindowWidth = $(window).width()
      resb_sidebar.make()

  $("#side_accordion").on "hidden shown", ->
    resb_sidebar.make()
    resb_sidebar.make_active()

  unless is_touch_device
    resb_tips.init()
    resb_popOver.init()
  resb_sidebar.init()
  resb_sidebar.make_active()


  resb_external_links.init()


is_touch_device = ("ontouchstart" of document.documentElement)
resb_sidebar =
  init: ->


    $(".sidebar").css "min-height", "100%"
    s_box = $(".sidebar_info")
    s_box.css
      "margin-top": "-" + s_box.outerHeight() + "px"
      position: "absolute"
      bottom: "52px"

    $(".sidebar_inner").css "padding-bottom", s_box.outerHeight() + 62
    $(".sidebar .accordion-toggle").click (e) ->
      e.preventDefault()

  make: ->
    $(".main_content").css "min-height", ""
    mH = $(".main_content").height()
    wH = $(window).height()
    sH = $(".sidebar_inner").height()
    if (wH > sH) and (wH > mH)
      $(".main_content").css "min-height", wH - 94
    else if sH > mH
      $(".main_content").css "min-height", sH
    else
      $(".main_content").css "min-height", mH

  make_active: ->
    thisAccordion = $("#side_accordion")
    
    active_accordian = RESocialBuilder.menu_active_accordian
    active_link = RESocialBuilder.menu_active_link
    
    if active_accordian
      $("#accordian_"+active_accordian).addClass "in" 
      
    if active_link
      $("#link_"+active_link).addClass "active" 
    
    
    # thisAccordion.find(".accordion-heading").removeClass "sdb_h_active"
    #     thisHeading = thisAccordion.find(".accordion-body.in").prev(".accordion-heading")
    #     thisHeading.addClass "sdb_h_active"  if thisHeading.length
    
    
  

resb_tips = init: ->
  shared =
    style:
      classes: "ui-tooltip-shadow ui-tooltip-tipsy"

    show:
      delay: 100
      event: "mouseenter focus"

    hide:
      delay: 0

  if $(".ttip_b").length
    $(".ttip_b").qtip $.extend({}, shared,
      position:
        my: "top center"
        at: "bottom center"
        viewport: $(window)
    )
  if $(".ttip_t").length
    $(".ttip_t").qtip $.extend({}, shared,
      position:
        my: "bottom center"
        at: "top center"
        viewport: $(window)
    )
  if $(".ttip_l").length
    $(".ttip_l").qtip $.extend({}, shared,
      position:
        my: "right center"
        at: "left center"
        viewport: $(window)
    )
  if $(".ttip_r").length
    $(".ttip_r").qtip $.extend({}, shared,
      position:
        my: "left center"
        at: "right center"
        viewport: $(window)
    )

resb_popOver = init: ->
  $(".pop_over").popover()


resb_external_links = init: ->
  $("a[href^='http']").each ->
    $(this).attr("target", "_blank").addClass "external_link"

