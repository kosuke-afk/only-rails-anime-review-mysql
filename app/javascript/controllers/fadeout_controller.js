import { Controller } from "@hotwired/stimulus";
import { fadeOut } from "../fadeout";

// Connects to data-controller="fadeout"
export default class extends Controller {
  connect() {
    fadeOut(this.element);
  }
}
