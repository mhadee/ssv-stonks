import consumer from "./consumer"

consumer.subscriptions.create("WebNotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    var html = '<div class="card mb-2"><header class="card-header"><p class="card-header-title has-text-centered">' +data.content.viewer_name+ ' '+data.content.event_type+ ' '+data.content.streamer_name+'</p></header></div>';
    $("#events").prepend(html);
    // Called when there's incoming data on the websocket for this channel
  }
});
