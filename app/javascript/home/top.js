import modal from "../custom/modal";

window.addEventListener("DOMContentLoaded", function () {
  new modal("modal", ".base-button", ".close-button", "mask");
});
