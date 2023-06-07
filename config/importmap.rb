# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "home/top"
pin "fadeout"
pin "mobile_menu"
pin_all_from "app/javascript/controllers", under: "controllers"


pin "gsap", to: "https://ga.jspm.io/npm:gsap@3.11.5/index.js"
pin "swiper", to: "https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.esm.browser.min.js"
pin "ssr-window", to: "https://ga.jspm.io/npm:ssr-window@4.0.2/ssr-window.esm.js"
