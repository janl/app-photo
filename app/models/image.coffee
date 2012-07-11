Spine = require('spine')

class Image extends Spine.Model
  @configure 'Image', 'name', 'filename', 'size', 'description'

  @extend Spine.Model.Hoodie

  @all: ->
    records = super
    now = new Date
    records.sort (a, b) -> 
      # 'now' is a workaround, as the remote post does not set created_at / updated_at timestamps ...
      (b.created_at or now) - (a.created_at or now)
    
  type       : 'image'
  description: ''

  url: ->
    return @_data_url if @_data_url
    
    # yeah, i'll optimize that, don't worry – or feel free
    baseURL = Spine.hoodie.base_url.replace('localhost:9292/', '')
    "#{baseURL}/#{encodeURIComponent Spine.hoodie.account.db()}/image%2f#{@id}/#{@filename or @name}" 
  
module.exports = Image
