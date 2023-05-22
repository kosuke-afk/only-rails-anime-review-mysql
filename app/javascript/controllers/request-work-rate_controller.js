import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["workRange"];

  connect() {
    this.workRangeTargets.forEach((target) => {
      let persent = target.value * 20;
      target.style.background = `linear-gradient(to right,red ${persent}%, #fff ${persent}%)`;
      target.addEventListener("input", (e) => {
        let persent = e.target.value * 20;
        target.style.background = `linear-gradient(to right,red ${persent}%, #fff ${persent}%)`;
        console.log(target.style.background);
      });
    });
  }
  submit() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.element.requestSubmit();
    }, 400);
  }
}
