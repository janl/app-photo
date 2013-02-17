require('lib/setup')

Spine   = require('spine')
Hoodie  = require('lib/spine-hoodie')
config  = require('lib/config')

Spine.hoodie = new Hoodie(config.hoodie_url)
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
    super

    # start routing
    Spine.Route.setup trigger: true

    # authenticate
    Spine.hoodie.account.authenticate()
    .done(@show_home)
    .fail(@show_login)

    # init image drop
    new ImageDropController el: @el

  show_login: =>
    @navigate '/login', true

  show_home: =>
    @navigate '/', true    
    
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
