export function fadeOut(target) {
  setTimeout(() => {
    target.classList.add("fade-out");
  }, 5000);
}
