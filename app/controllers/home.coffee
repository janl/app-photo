Spine = require('spine')
Image = require('models/image')

class Home extends Spine.Controller
  
  events:
    'click .delete': 'delete'

  model: Image

  constructor: ->
    super
    
    Image.bind 'refresh change', @render

    Image.fetch()

  render: =>
    @el.html require('views/stream') @

  # active: (params) ->
  #   super
  

  delete: (event) -> 
    id = $(event.target).closest('[data-id]').data 'id'

    Image.destroy id
    return false
    
module.exports = Home