Spine = require('spine')
Image = require 'models/image'

class ImageDrop extends Spine.Controller
  events:
    'dragenter': 'dragenter'
    'dragleave': 'dragleave'
    'drop'     : 'drop'

  constructor: ->
    super

  drop: (event) =>
    event.preventDefault()
    @el.removeClass 'drag-hover'

    @_loadFile(file) for file in event.originalEvent.dataTransfer.files


  dragenter: (event) ->
    @el.addClass 'drag-hover'


  dragleave: (event) ->
    @el.removeClass 'drag-hover'


  # ## private


  _loadFile: (file) =>
    console.log '_loadFile', file
    reader = new FileReader

    reader.onload = (event) =>

      image_object =
        name    : file.name,
        filename: file.name,
        size    : file.size,
        type    : 'image',
        id      : Spine.hoodie.uuid(7)
      
      _attachments = {}
      _attachments[file.name] =
        content_type : file.type

        # strip the "data:image/png;base64," part
        data         : event.target.result.substr 13 + file.type.length

      Spine.hoodie.store.save(image_object.type, image_object.id, image_object)
      .done (object) =>
        console.log 'refresh!!', $.extend {_url: event.target.result}, object
        Image.refresh $.extend {_url: event.target.result}, object

        object._attachments = _attachments
        Spine.hoodie.remote.push([object])
        .done( -> console.log('image uploaded', object, arguments) )
        .fail( -> console.log('image upload failed', object, arguments) )

    reader.readAsDataURL(file)

    
module.exports = ImageDrop