// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

document.addEventListener("turbo:before-fetch-response", (event) => {
  if (
    event.detail.fetchResponse.header("X-Turbo-Connect") &&
    typeof event.detail.fetchResponse !== "undefined"
  ) {
    var response = event.detail.fetchResponse.response;
    if (response.redirected) {
      console.log("need redirect");
      event.preventDefault();
      Turbo.visit(response.url, { action: "replace" });
    }
  }
});
