import consumer from "channels/consumer"

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connected to notifications channel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    this.displayNotification(data);
    this.createBackendNotification(data);
  },

  displayNotification(data) {
    if (!("Notification" in window)) {
      console.warn("This browser does not support desktop notification");
    } else if (Notification.permission === "granted") {

      var notification = new Notification(data.title, { body: data.body });

      console.log("body: " + data.body);
      const notificationDiv = document.getElementById('notifications-div')
      
      const html = this.createNotification(data)
      notificationDiv.innerHTML = notificationDiv.innerHTML +  html
      // TODO: fetch call to new_notification_path to create a new Notification model
 
      const notificationData = {
        content: data.body,
        user_id: 7
      }
      // create a new notification with body and user_id 
      
    } else if (Notification.permission !== "denied") {
      console.log("notification permissions need to be requested");
    } else {
      console.warn("notification denied");
    }
  },

  async createBackendNotification(data) {
    try {
      const response = await fetch('/new_notification_path', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({
          notification: {
            content: data.body,
            user_id: 7 // Replace 7 with the actual user ID
          }
        })
      });

      if (!response.ok) {
        throw new Error('Failed to create notification');
      }

      const notificationData = await response.json();
      console.log('New notification created:', notificationData);
    } catch (error) {
      console.error('Error creating notification:', error);
    }
  },

  createNotification(data) {
    return `
      <div class="flex items-center justify-center rounded-md hover:bg-blue-300">
        <P class="text-sm font-medium">${data.body}</P>
      </div>
    `
  }
});
