#
# Spine ♥ Hoodie
#
# To use Hoodie as a Store for spine.js apps, require `spine-hoodie.coffee` in
# you bootstrap file and then extend your Models usin `Spine.Model.Hoodie`
#
#   Hoodie       = require('lib/spine-hoodie')
#   Spine.hoodie = new Hoodie(config.hoodie_url)
# 
#   class Car extends Spine.Model
#     @configure 'Image', 'color'
#     @extend Spine.Model.Hoodie
#

Spine.Model.Hoodie = 

  # extend the Model
  extended: ->

    # add type to attributes.
    # Turns `@configure 'Image', 'color'` into `@configure 'Image', 'type', 'color'`
    type = @className.toLowerCase()
    @attributes.unshift 'type'

    @change (object, event, data) =>
      switch event
        when 'create'
          console.log 'create', type, object.toJSON()
          Spine.hoodie.store.create type, object.toJSON()
        when 'update'
          console.log 'update', type, object.id, object.toJSON()
          Spine.hoodie.store.update type, object.id, object.toJSON()
        when 'destroy'
          console.log 'destroy', type, object.id
          Spine.hoodie.store.destroy type, object.id

    # fetch records from hoodie.store
    @fetch =>
      Spine.hoodie.store.loadAll(type)
      .done (records) => @refresh(records)

    # listen to remote events on records
    Spine.hoodie.remote.on "changed:#{type}", (event, remoteObject) => 
      switch event
        when 'created'
          @refresh remoteObject
        when 'destroyed'
          @destroy remoteObject.id
        when 'updated'
          localObject = @find(remoteObject.id)
          for attr, value of remoteObject
            localObject[attr] = value
          localObject.save()

module?.exports = Hoodie