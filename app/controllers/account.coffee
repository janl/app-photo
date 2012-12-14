Spine = require('spine')

class Account extends Spine.Controller
  events:
    'submit form': 'sign_up_or_in'

  constructor: ->
    super
    @render()

  active : (params) ->
    Spine.hoodie.account.signOut()
    super

  render : ->
    @el.html require('views/login') this


  sign_up_or_in : (event) ->
    event.preventDefault()

    @$email    or= @$('input[name=email]')
    @$password or= @$('input[name=password]')

    email    = @$email.val()
    password = @$password.val()

    sign_in_promise = Spine.hoodie.account.signIn(email, password)
    sign_in_promise.done @hide_login
    sign_in_promise.fail =>
      sign_up_promise = Spine.hoodie.account.signUp(email, password)
      sign_up_promise.done @hide_login
      sign_up_promise.fail ->
        alert 'oops, something went wrong, buddy! Maybe try again?'

  hide_login : =>
    console.log 'hide_login'
    @navigate '/'

module.exports = Account