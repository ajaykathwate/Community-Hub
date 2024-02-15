import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share"
export default class extends Controller {
  static targets = ["name", "user"];

  connect() {
    console.log("Connected to share controller...");
    console.log(this.data.get("urlValue"));
  }

  async share(e) {
    e.preventDefault();

    const shareData = {
      url: this.data.get("urlValue"),
    };
    try {
      await navigator.share(shareData);
      // this.resultTarget.textContent = "MDN shared successfully";
      console.log("Community share link sent successfully!");
    } catch (err) {
      this.resultTarget.textContent = `Error: ${err}`;
    }
  }

}
