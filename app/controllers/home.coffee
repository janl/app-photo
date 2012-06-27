Spine = require('spine')
Image = require('models/image')

class Home extends Spine.Controller
  
  events:
    'click .delete': 'delete'

  model: Image

  constructor: ->
    super
    
    Image.bind 'refresh change', @render
    hoodie.store.loadAll('image').done (records) => 
      console.log 'records', records
      Image.refresh records

  render: =>
    @el.html require('views/stream') @

  active: (params) ->
    console.log 'home sweet home'
    super
  

  delete: (event) -> 
    id = $(event.target).closest('[data-id]').data 'id'

    hoodie.store.destroy('image', id)
    .done -> Image.destroy id

    return false
    
module.exports = Home