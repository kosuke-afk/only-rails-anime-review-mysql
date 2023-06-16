import { Controller } from "@hotwired/stimulus";
import Swiper from "swiper";
export default class extends Controller {
  static targets = ["swiper"];

  connect() {
    const mobileOption = {
      loop: true,
      initialSlide: 0,
      autoplay: {
        disableOnInteraction: true,
      },
    };

    const tabletOption = {
      effect: "coverflow",
      loop: true,
      initialSlide: 0,
      autoplay: {
        disableOnInteraction: true,
      },
      // centerInsufficientSlides: true,
      centeredSlides: true,
      slidesPerView: 3,
      coverflowEffect: {
        rotate: -30,
        stretch: 0,
        slideShadows: false,
        modifier: 1,
      },
    };
    const mqMobile = window.matchMedia("(max-width:880px)");
    const mqTablet = window.matchMedia("(min-width:881px)");
    this.swiperTargets.forEach((swiper) => {
      if (window.outerWidth >= 881) {
        new Swiper(swiper, tabletOption);
      } else if (window.outerWidth <= 880) {
        new Swiper(swiper, mobileOption);
      }
      mqMobile.addEventListener("change", (e) => {
        if (e.matches) {
          swiper.swiper.destroy(true, true);
          new Swiper(swiper, mobileOption);
        }
      });
      mqTablet.addEventListener("change", (e) => {
        if (e.matches) {
          swiper.swiper.destroy(true, true);
          new Swiper(swiper, tabletOption);
        }
      });
    });

    // let impressedSwiper = document.querySelector(".impressed-swiper").swiper;
    // let loveSwiper = document.querySelector(".love-swiper").swiper;
    // let comedySwiper = document.querySelector(".comedy-swiper").swiper;
    // let excitementSwiper = document.querySelector(".excitement-swiper").swiper;
    // let deepSwiper = document.querySelector(".deep-swiper").swiper;
    // let totalSwiper = document.querySelector(".total-swiper").swiper;

    // mqMobile.addEventListener("change", (e) => {
    //   if (e.matches) {
    //     totalSwiper.destroy(true, true);
    //     totalSwiper = new Swiper(".total-swiper", mobileOption);
    //     impressedSwiper.destroy(true, true);
    //     impressedSwiper = new Swiper(".impressed-swiper", mobileOption);
    //     loveSwiper.destroy(true, true);
    //     loveSwiper = new Swiper(".love-swiper", mobileOption);
    //     comedySwiper.destroy(true, true);
    //     comedySwiper = new Swiper(".comedy-swiper", mobileOption);
    //     excitementSwiper.destroy(true, true);
    //     excitementSwiper = new Swiper(".excitement-swiper", mobileOption);
    //     deepSwiper.destroy(true, true);
    //     deepSwiper = new Swiper(".deep-swiper", mobileOption);
    //   }
    // });

    // mqTablet.addEventListener("change", (e) => {
    //   if (e.matches) {
    //     totalSwiper.destroy(true, true);
    //     totalSwiper = new Swiper(".total-swiper", tabletOption);
    //     impressedSwiper.destroy(true, true);
    //     impressedSwiper = new Swiper(".impressed-swiper", tabletOption);
    //     loveSwiper.destroy(true, true);
    //     loveSwiper = new Swiper(".love-swiper", tabletOption);
    //     comedySwiper.destroy(true, true);
    //     comedySwiper = new Swiper(".comedy-swiper", tabletOption);
    //     excitementSwiper.destroy(true, true);
    //     excitementSwiper = new Swiper(".excitement-swiper", tabletOption);
    //     deepSwiper.destroy(true, true);
    //     deepSwiper = new Swiper(".deep-swiper", tabletOption);
    //   }
    // });
  }
}
