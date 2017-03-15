App.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    console.log("connected")

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
      console.log("client receives ", data)
      $(".jmessages").prepend(data.message)