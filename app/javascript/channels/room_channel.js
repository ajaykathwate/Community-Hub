import consumer from "channels/consumer"

const room_element = document.getElementById('chat-room-id');
const chat_room_id = room_element.getAttribute('data-chat-room-id');

consumer.subscriptions.create({channel: "RoomChannel", chat_room_id: chat_room_id}, {
  connected() {

    console.log("Connected to ActionCable..." + chat_room_id);
    const msgContainer = document.getElementById('messages')
    msgContainer.lastElementChild.scrollIntoView({behavior: "smooth"})
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
