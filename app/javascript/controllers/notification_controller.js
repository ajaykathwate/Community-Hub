import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification"
export default class extends Controller {
  connect() {
    const notificationBtn = document.getElementById('btn-request-notification-permission');
    // Do an initial check to see what the notification permission state is
    if (Notification.permission === 'denied' || Notification.permission === 'default') {
      notificationBtn.style.display = 'block';
    } else {
      notificationBtn.style.display = 'none';
    }
  }
 

  requestPermission() {
    const notificationRequestDiv = document.getElementById('btn-request-notification-permission')
    Notification.requestPermission().then(function (permission) {
      if (permission === "granted") {
        const notificationBtn = document.getElementById('btn-request-notification-permission');  
        // Do an initial check to see what the notification permission state is
        notificationBtn.style.display = 'none';
      }
    });
  }
}
