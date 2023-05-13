// app/javascript/controllers/signup_form_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["form", "errorContainer", "errorMessages"];

  submit(event) {
    event.preventDefault();

    const form = this.formTarget;
    const url = form.action;
    const formData = new FormData(form);

    fetch(url, {
      method: form.method,
      body: formData,
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        Accept: "text/html",
        "Content-Type": "application/x-www-form-urlencoded",
      },
    })
      .then((response) => response.text())
      .then((data) => {
        if (data.includes("error_explanation")) {
          this.errorMessagesTarget.innerHTML = data;
        } else {
          // Handle successful form submission if desired
        }
      })
      .catch((error) => {
        console.error("An error occurred during form submission:", error);
      });
  }
}
