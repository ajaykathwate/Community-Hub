import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  
  static targets = ["form"]
  
  connect() {
    console.log("connected to search controller...");
  }

  search(){
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit();
    }, 100);
  }
  
}
