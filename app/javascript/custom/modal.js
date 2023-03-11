export default class Modal {
  constructor(modal, openButton, closeButton, mask) {
    this.modal = document.getElementById(modal);
    this.buttons = document.querySelectorAll(openButton);
    this.closeButton = document.querySelector(closeButton);
    this.mask = document.getElementById(mask) || null;
    this._addOpenEvent(this.buttons);
    this._addCloseEvent(this.closeButton);
    if (this.mask != null) {
      this._addCloseEvent(this.mask);
    }
  }

  _addOpenEvent(doms) {
    if (doms.length >= 2) {
      doms.forEach((dom) => {
        dom.addEventListener("click", () => {
          this.modal.classList.remove("hidden");
          if (this.mask != null) {
            this.mask.classList.remove("hidden");
          }
        });
      });
    } else {
      const dom = doms;
      dom.addEventListener("click", () => {
        this.modal.classList.remove("hidden");
        if (this.mask != null) {
          this.mask.classList.remove("hidden");
        }
      });
    }
  }

  _addCloseEvent(dom) {
    dom.addEventListener("click", () => {
      if (this.mask != null) {
        this.mask.classList.add("hidden");
      }
      this.modal.classList.add("hidden");
    });
  }
}
