import Swiper from "swiper";

const mobileOption = {
  loop: true,
  autoplay: {
    disableOnInteraction: true,
  },
};

const tabletOption = {
  effect: "coverflow",
  loop: true,
  autoplay: {
    disableOnInteraction: true,
  },
  slidesPerView: 3,
  coverflowEffect: {
    rotate: -30,
    stretch: 0,
    slideShadows: false,
    modifier: 1,
  },
};

if (window.outerWidth >= 881) {
  new Swiper(".total-swiper", tabletOption);
  new Swiper(".impressed-swiper", tabletOption);
  new Swiper(".love-swiper", tabletOption);
  new Swiper(".comedy-swiper", tabletOption);
  new Swiper(".excitement-swiper", tabletOption);
  new Swiper(".deep-swiper", tabletOption);
} else if (window.outerWidth <= 880) {
  new Swiper(".total-swiper", mobileOption);
  new Swiper(".impressed-swiper", mobileOption);
  new Swiper(".love-swiper", mobileOption);
  new Swiper(".comedy-swiper", mobileOption);
  new Swiper(".excitement-swiper", mobileOption);
  new Swiper(".deep-swiper", mobileOption);
}

const mqMobile = window.matchMedia("(max-width:880px)");
const mqTablet = window.matchMedia("(min-width:881px)");
let impressedSwiper = document.querySelector(".impressed-swiper").swiper;
let loveSwiper = document.querySelector(".love-swiper").swiper;
let comedySwiper = document.querySelector(".comedy-swiper").swiper;
let excitementSwiper = document.querySelector(".excitement-swiper").swiper;
let deepSwiper = document.querySelector(".deep-swiper").swiper;
let totalSwiper = document.querySelector(".total-swiper").swiper;

mqMobile.addEventListener("change", (e) => {
  if (e.matches) {
    totalSwiper.destroy(true, true);
    totalSwiper = new Swiper(".total-swiper", mobileOption);
    impressedSwiper.destroy(true, true);
    impressedSwiper = new Swiper(".impressed-swiper", mobileOption);
    loveSwiper.destroy(true, true);
    loveSwiper = new Swiper(".love-swiper", mobileOption);
    comedySwiper.destroy(true, true);
    comedySwiper = new Swiper(".comedy-swiper", mobileOption);
    excitementSwiper.destroy(true, true);
    excitementSwiper = new Swiper(".excitement-swiper", mobileOption);
    deepSwiper.destroy(true, true);
    deepSwiper = new Swiper(".deep-swiper", mobileOption);
  }
});

mqTablet.addEventListener("change", (e) => {
  if (e.matches) {
    totalSwiper.destroy(true, true);
    totalSwiper = new Swiper(".total-swiper", tabletOption);
    impressedSwiper.destroy(true, true);
    impressedSwiper = new Swiper(".impressed-swiper", tabletOption);
    loveSwiper.destroy(true, true);
    loveSwiper = new Swiper(".love-swiper", tabletOption);
    comedySwiper.destroy(true, true);
    comedySwiper = new Swiper(".comedy-swiper", tabletOption);
    excitementSwiper.destroy(true, true);
    excitementSwiper = new Swiper(".excitement-swiper", tabletOption);
    deepSwiper.destroy(true, true);
    deepSwiper = new Swiper(".deep-swiper", tabletOption);
  }
});
