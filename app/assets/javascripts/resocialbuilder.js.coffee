window.RESocialBuilder = 
  Translations: {}
  Routers: {}
  Models: {}
  Collections: {}
  Views: {}
  init: -> 
    new RESocialBuilder.Routers.Application()
    Backbone.history.start(pushState: true)
    
jQuery ->
  
  RESocialBuilder.init()
