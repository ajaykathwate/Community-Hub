import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  reset(){
    this.element.reset();
    const e = document.getElementById("#image-preview")
    if (e) {
    e.classList.add("hidden");
    console.log(e);
  }
  }
}
