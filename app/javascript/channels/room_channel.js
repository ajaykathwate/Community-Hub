import consumer from "channels/consumer"

consumer.subscriptions.create({channel: "RoomChannel", chat_room_id: 25}, {
  connected() {

    console.log("Connected to ActionCable...");
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data.html);
    const msgContainer = document.getElementById('messages')
    console.log("MessageContainer: " + msgContainer);
    msgContainer.innerHTML = msgContainer.innerHTML +  data.html
    msgContainer.lastElementChild.scrollIntoView({behavior: "smooth"})
  }
});
