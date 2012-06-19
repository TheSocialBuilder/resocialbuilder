$(document).ready ->
  
  resb_sidebar.make()
  
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

    
  
  $(".search_query").typeahead
    source: [ "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Dakota", "North Carolina", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming" ]
    items: 4

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
  resb_crumbs.init()
  prettyPrint()
  resb_external_links.init()
  resb_style.init()

is_touch_device = ("ontouchstart" of document.documentElement)
resb_sidebar =
  init: ->
    if $(window).width() > 767
      unless $("body").hasClass("sidebar_hidden")
        if $.cookie("resb_sidebar") is "hidden"
          $("body").addClass "sidebar_hidden"
          $(".sidebar_switch").toggleClass("on_switch off_switch").attr "title", "Show Sidebar"
      else
        $(".sidebar_switch").toggleClass("on_switch off_switch").attr "title", "Show Sidebar"
    else
      $("body").addClass "sidebar_hidden"
      $(".sidebar_switch").removeClass("on_switch").addClass "off_switch"
    $(".sidebar_switch").click ->
      $(this).qtip "hide"  unless is_touch_device
      $(".sidebar_switch").removeClass "on_switch off_switch"
      if $("body").hasClass("sidebar_hidden")
        $.cookie "resb_sidebar", null
        $("body").removeClass "sidebar_hidden"
        $(".sidebar_switch").addClass("on_switch").show()
        $(".sidebar_switch").attr "title", "Hide Sidebar"
      else
        $.cookie "resb_sidebar", "hidden"
        $("body").addClass "sidebar_hidden"
        $(".sidebar_switch").addClass "off_switch"
        $(".sidebar_switch").attr "title", "Show Sidebar"
      $(window).resize()
      resb_sidebar.make()

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
    thisAccordion.find(".accordion-heading").removeClass "sdb_h_active"
    thisHeading = thisAccordion.find(".accordion-body.in").prev(".accordion-heading")
    thisHeading.addClass "sdb_h_active"  if thisHeading.length
    
    
  

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

resb_crumbs = init: ->
  $("#jCrumbs").jBreadCrumb
    endElementsToLeaveOpen: 0
    beginingElementsToLeaveOpen: 0
    timeExpansionAnimation: 500
    timeCompressionAnimation: 500
    timeInitialCollapse: 500
    previewWidth: 30

resb_external_links = init: ->
  $("a[href^='http']").each ->
    $(this).attr("target", "_blank").addClass "external_link"

resb_style = init: ->
  $(".style_switcher a").click ->
    $("#link_theme").attr "href", "css/" + $(this).attr("title") + ".css"
    $(".style_switcher a").removeClass "th_active"
    $(this).addClass "th_active"