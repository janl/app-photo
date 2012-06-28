Spine = require('spine')
Image = require 'models/image'


class ImageController extends Spine.Controller

  # constructor: ->
  #   super
  #   @render()

  render: ->
    console.log 'render'
    @html require('views/image') this    

  active: (params) ->
    @record = Image.find params.id
    @render()

    super
    
module.exports = ImageController