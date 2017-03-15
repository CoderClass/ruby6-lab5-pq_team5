App.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    console.log("connected")

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
      console.log("client receives ", data)
      $(".jmessages").prepend(data.message)

  $(document).on "turbolinks:load", ->
  
    $("form#js-socket").submit (event) ->
      console.log("stopping submitting via HTTP")
      event.preventDefault()

      # use jQuery to find the text input:
      $input = $(this).find('input:text')
      data = {message: {body: $input.val()}}
      console.log("sending over socket: ", data)
      App.messages.send(data)
      # clear text field
      $input.val('')