import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["studentRoleCheckbox", "groupSelect"];

  connect() {
    this.toggleGroupSelect();
    this.studentRoleCheckboxTarget.addEventListener("change", this.toggleGroupSelect.bind(this));
  }

  toggleGroupSelect() {
    if (this.studentRoleCheckboxTarget.checked) {
      this.groupSelectTarget.style.display = "block";
    } else {
      this.groupSelectTarget.style.display = "none";
    }
  }
}
