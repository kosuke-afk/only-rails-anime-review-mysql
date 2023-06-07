import { Controller } from "@hotwired/stimulus";
import Swiper from "swiper";
export default class extends Controller {
  connect() {
    if (window.outerWidth <= 600) {
      new Swiper(".mySwiper", {
        loop: true,
        autoplay: {
          disableOnInteraction: true,
        },
      });
    } else {
      new Swiper(".mySwiper", {
        effect: "coverflow",
        loop: true,
        autoplay: {
          disableOnInteraction: true,
        },
        grabCursor: true,
        slidesPerView: 3,
        coverflowEffect: {
          rotate: -30,
          stretch: 0,
          depth: 0,
          slideShadows: false,
          modifier: 1,
        },
      });
    }

    let mySwiper = document.querySelector(".mySwiper").swiper;
    const mqMobile = window.matchMedia("(max-width:600px)");
    const mqTablet = window.matchMedia("(min-width:601px)");

    mqMobile.addEventListener("change", (e) => {
      if (e.matches) {
        mySwiper.destroy(true, true);
        mySwiper = new Swiper(".mySwiper", {
          loop: true,
          autoplay: {
            disableOnInteraction: true,
          },
        });
      }
    });

    mqTablet.addEventListener("change", (e) => {
      if (e.matches) {
        mySwiper.destroy(true, true);
        mySwiper = new Swiper(".mySwiper", {
          effect: "coverflow",
          loop: true,
          autoplay: {
            disableOnInteraction: true,
          },
          grabCursor: true,
          slidesPerView: 3,
          coverflowEffect: {
            rotate: -30,
            stretch: 0,
            depth: 0,
            slideShadows: false,
            modifier: 1,
          },
        });
      }
    });
    const pauseButton = document.querySelector(".paused");
    pauseButton.addEventListener("click", () => {
      swiper.autoplay.pause();
    });
    const resumeButton = document.querySelector(".resume");
    resumeButton.addEventListener("click", () => {
      swiper.autoplay.resume();
    });
  }
}
