require('lib/setup')

Spine   = require('spine')
Hoodie  = require('lib/spine-hoodie')

ImageDropController = require('controllers/image_drop')

class App extends Spine.Stack

  controllers:
    account : require('controllers/account')
    home    : require('controllers/home')
    image   : require('controllers/image')

  routes: 
    '/login'     : 'account'
    '/'          : 'home'
    '/image/:id' : 'image'

  # global events
  events:
    "click a": "_navigate"

  constructor: (options) ->
    # init Spine
    Spine.hoodie = new Hoodie("http://localhost:9292/localhost:5984")

    super

    # start routing
    Spine.Route.setup trigger: true

    # authenticate
    Spine.hoodie.account.authenticate().fail @show_login

    # init image drop
    new ImageDropController el: @el

  show_login: =>
    @navigate '/login', true

    
  _navigate: (event) ->
    $a = $ event.currentTarget

    href = $a.attr('href')
    
    if /^\//.test href
      
      # if href.indexOf('?') is -1
      #   @navigate href
      # else
      #   [path, query] = href.split('?')
      #   
      #   @navigate path, $.deparam(query)
      
      @navigate href
      event.preventDefault()
      return
      
    if href is '#'
      event.preventDefault()

module.exports = App
