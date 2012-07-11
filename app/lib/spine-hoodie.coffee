Spine.Model.Hoodie = 
  extended: ->
    # add type to attributes
    type = @className.toLowerCase()
    @attributes.unshift type

    @change (object, event, data) =>
      console.log 'change!'
      console.log 'object', object
      console.log 'event', event
      console.log 'data', data

    @fetch  =>
      console.log 'fetch!'
      Spine.hoodie.store.loadAll(type)
      .done (records) => @refresh(records)

module?.exports = Hoodie