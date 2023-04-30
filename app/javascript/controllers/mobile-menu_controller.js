import { Controller } from "@hotwired/stimulus";
import { MobileMenu } from "../mobile_menu";

// Connects to data-controller="mobile-menu"
export default class extends Controller {
  connect() {
    console.log("mobile");
    new MobileMenu();
  }
}
