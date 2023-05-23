import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["episodeRange"];

  connect() {
    this.episodeRangeTargets.forEach((target) => {
      let persent = target.value;
      target.style.background = `linear-gradient(to right,red ${persent}%, #fff ${persent}%)`;
      target.addEventListener("input", (e) => {
        let persent = e.target.value;
        target.style.background = `linear-gradient(to right,red ${persent}%, #fff ${persent}%)`;
      });
    });
  }

  submit() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.element.requestSubmit();
    }, 1000);
  }
}
