Spine.Model.Hoodie = 
  extended: ->
    # add type to attributes
    type = @className.toLowerCase()
    @attributes.unshift 'type'

    @change (object, event, data) =>
      console.log 'change!'
      console.log 'object', object
      console.log 'event', event
      console.log 'data', data

    @fetch =>
      Spine.hoodie.store.loadAll(type)
      .done (records) => @refresh(records)

    Spine.hoodie.remote.on "changed:#{type}", (event, remoteObject) => 
      console.log event, remoteObject
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

module?.exports = Spine.Model.Hoodie