export class MobileMenu {
  constructor() {
    this.Dom = {};
    this.Dom.global = document.querySelector("#global-container");
    this.Dom.btn = document.querySelector(".humberger");
    this.Dom.cover = document.querySelector(".mobile-menu__cover");
    this.eventType = this._getEventType();
    this._addEvent();
  }

  _getEventType() {
    const isTouchCapable =
      "ontouchstart" in window ||
      (window.DocumentTouch && document instanceof DocumentTouch);
    return isTouchCapable ? "touchstart" : "click";
  }
  _toggle() {
    this.Dom.global.classList.toggle("menu-open");
  }
  _addEvent() {
    this.Dom.btn.addEventListener(this.eventType, this._toggle.bind(this));
    this.Dom.cover.addEventListener(this.eventType, this._toggle.bind(this));
  }
}
