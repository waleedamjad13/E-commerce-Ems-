document.addEventListener("DOMContentLoaded", () => {
  document.addEventListener("click", (event) => {
    const signupLink = event.target.closest("#signup-link");
    const signupSection = document.getElementById("signup-section");

    if (signupLink) {
      event.preventDefault();
      signupSection.classList.toggle("hidden");
    }
  });
});
