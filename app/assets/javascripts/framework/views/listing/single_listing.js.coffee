class RESocialBuilder.Views.SingleListing extends Backbone.View
  template: JST['listing/listing']
  tagName: 'div'
  className: 'modal'




  initialize: ->
    
  render:  =>

    $(@el).html(@template(listing: @model))
    @

