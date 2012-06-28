Spine = require('spine')

class Image extends Spine.Model
  @configure 'Image', 'name', 'filename', 'size', 'description'


  @all: ->
    records = super
    records.sort (a, b) -> b.created_at - a.created_at
    
  type       : 'image'
  description: ''

  url: ->
    return @_url if @_url
    
    # yeah, i'll optimize that, don't worry – or feel free
    baseURL = hoodie.base_url.replace('localhost:9292/', '')
    "#{baseURL}/#{encodeURIComponent hoodie.account.db()}/image%2f#{@id}/#{@filename or @name}" 
  
module.exports = Image