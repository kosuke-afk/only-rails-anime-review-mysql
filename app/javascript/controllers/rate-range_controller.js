import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["score", "range"];
  connect() {
    const value = this.rangeTarget.value;
    this.scoreTarget.innerText = value;
    this.rangeTarget.addEventListener("input", (e) => {
      const value = e.target.value;
      this.scoreTarget.innerText = value;
    });
  }
}
