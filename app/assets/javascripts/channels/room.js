jQuery(document).on('turbolinks:load', function() {
  var messages, messages_to_bottom;

  messages = $('#messages');

  if ($('#messages').length > 0) {
    messages_to_bottom = function() {
      return messages.scrollTop(messages.prop("scrollHeight"));
    };

    messages_to_bottom();

    App.global_room = App.cable.subscriptions.create({
      channel: "RoomsChannel",
      room_id: messages.data('room-id')
    }, {
      connected: function() {},

      disconnected: function() {},

      received: function(data) {
        messages.append(data['message']);
        return messages_to_bottom();
      },

      send_message: function(message, room_id) {
        return this.perform('send_message', {
          message: message,
          room_id: room_id
        });
      }
    });

    return $('#new_message').submit(function(e) {
      var $this, textarea;

      $this = $(this);
      textarea = $this.find('#message_body');

      if ($.trim(textarea.val()).length > 1) {
        App.global_room.send_message(textarea.val(), messages.data('room-id'));

        var message = String(textarea.val()).split('');
        var letters = [];
        for (var i = 0; i < message.length; i++) {
          if (message[i] === '@' && message[i + 1] !== ' ') {
            var counter = i + 1;
            var letter = message[counter];
            while (letter !== ' ' && letter !== '.' && letter !== '!' && letter !== '?' && counter < message.length) {
              letters.push(letter);
              counter++;
              letter = message[counter];
            }
          }
        }
        var person = letters.join('')
        // send email to person
        textarea.val('');
      }
      e.preventDefault();
      return false;
    });
  }
});
