var messages = $('#messages');
if (messages.length > 0) {
  var messagesToBottom = function() {
    return messages.scrollTop(messages.prop("scrollHeight"));
  };

  messagesToBottom();
  App.room = App.cable.subscriptions.create({
    channel: "RoomsChannel",
    room_id: messages.data('room-id'),

    connected: function() {
      // Called when the subscription is ready for use on the server
    },

    disconnected: function() {
      // Called when the subscription has been terminated by the server
    },

    received: function(data) {
      messages.append(data['message']);
      messagesToBottom();
    },

    send_message: function(message, room_id) {
      return this.perform('send_message', {
        message: message,
        room_id: room_id
      });
    }
  });

  $('#new_message').submit(function(e) {
    var $this, textarea;
    $this = $(this);
    textarea = $this.find('#message_body');
    if ($.trim(textarea.val()).length > 0) {
      App.global_chat.send_message(textarea.val(), messages.data('chat-room-id'));
      textarea.val('');
    }
    e.preventDefault();
    return false;
  });
}
