$(document).ready ->
  
  $('.accordian').accordion();

  
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



