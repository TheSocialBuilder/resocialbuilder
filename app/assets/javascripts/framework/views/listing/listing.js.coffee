class RESocialBuilder.Views.Listing extends Backbone.View
  template: JST['listing/listings']
  tagName: 'div'
  className: 'listing'

  events:
    'click .extra': 'incrementExtra'
    'click': 'clickListing'
    


  initialize: =>
    # alert "Load Listing"

  render: =>
    # 
    # console.log @model
    $(@el).html(@template(listing: @model))
    @

  clickListing: =>
    # alert "Listing Popup"
    $('.modal').remove()
    
    id = @model.get('listing')
    # Backbone.history.navigate("listings/"+id)

    singleListing = new RESocialBuilder.Views.SingleListing(model: @model)
    $('body').prepend(singleListing.render().el)
    $('.modal').modal()
    # $('.listings_scoll').cycle() if $('.listings_scoll').length !=0
    
  incrementExtra: (event) =>
    extra = $(event.currentTarget)
    value = parseInt(extra.find('span').html())
    extra.find('span').html(value + 1)