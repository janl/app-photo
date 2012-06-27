require('lib/setup')

Spine = require('spine')
ImageDropController = require('controllers/image_drop')

class App extends Spine.Stack

  controllers:
    account : require('controllers/account')
    home    : require('controllers/home')

  routes: 
    '/login' : 'account'

    '/' : 'home'
    ''  : 'home'

  # global events
  events:
    "click a": "_navigate"

  constructor: (options) ->

    super

    # start routing
    Spine.Route.setup trigger: true

    # authenticate
    hoodie.account.authenticate().fail @show_login

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
      return false
      
    if href is '#'
      return false

module.exports = App
