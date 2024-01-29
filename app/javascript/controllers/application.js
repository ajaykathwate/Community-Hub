import { Application } from "@hotwired/stimulus"
global.toastr = require("toastr")
const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
