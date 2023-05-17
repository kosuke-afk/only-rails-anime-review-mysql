export default class Modal {
  constructor({ modal, openButton, className, mask = "top-modal__mask" }) {
    this.modal = document.getElementById(modal);
    this.button = document.getElementById(openButton);
    this.mask = document.getElementById(mask);
    this._addOpenEvent(this.button, className);
    this.addCloseEvent(this.mask);
  }

  _addOpenEvent(dom, className) {
    dom.addEventListener("click", () => {
      this.modal.classList.add("open", className);
      this.mask.classList.add("open");
    });
  }

  addCloseEvent(dom) {
    dom.addEventListener("click", () => {
      this.modal.classList.remove(...this.modal.classList);
      this.mask.classList.remove("open");
    });
  }
}
