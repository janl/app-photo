Spine = require('spine')

class Image extends Spine.Model
  @configure 'Image', 'name', 'filename', 'size'

  type: 'image'

  url: ->
    return @_url if @_url
    
    # yeah, i'll optimize that, don't worry – or feel free
    baseURL = hoodie.base_url.replace('localhost:9292/', '')
    "#{baseURL}/#{encodeURIComponent hoodie.account.db()}/image%2f#{@id}/#{@filename}" 
  
module.exports = Image