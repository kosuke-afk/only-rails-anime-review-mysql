export default class Modal {
  constructor(modal, openButton, closeButton, mask) {
    this.modal = document.getElementById(modal);
    this.buttons = document.querySelectorAll(openButton);
    this.closeButton = document.querySelector(closeButton);
    this.mask = document.getElementById(mask) || null;
    this.addOpenEvent(this.buttons);
    this.addCloseEvent(this.closeButton);
    if (this.mask != null) {
      this.addCloseEvent(this.mask);
    }
  }

  addOpenEvent(doms) {
    doms.forEach((dom) => {
      dom.addEventListener("click", () => {
        this.modal.classList.remove("hidden");
        if (this.mask != null) {
          this.mask.classList.remove("hidden");
        }
      });
    });
  }

  addCloseEvent(dom) {
    dom.addEventListener("click", () => {
      if (this.mask != null) {
        this.mask.classList.add("hidden");
      }
      this.modal.classList.add("hidden");
    });
  }
}
