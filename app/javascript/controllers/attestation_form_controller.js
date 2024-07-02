import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="attestation-form"
export default class extends Controller {
  static targets = ["groupSelect", "subjectSelect"];

  connect() {
    this.groupSelectTargets.forEach((element) => {
      element.addEventListener("change", this.fetchSubjects.bind(this));
    });
  }

  fetchSubjects() {
    const groupIds = Array.from(this.groupSelectTargets)
      .filter((element) => element.checked)
      .map((element) => element.value);

    if (groupIds.length > 0) {
      fetch(`/subjects/group_subjects?group_ids=${groupIds.join(",")}`)
        .then(response => response.json())
        .then(data => {
          const subjects = data;
          this.populateSelect(this.subjectSelectTarget, subjects);
        });
    } else {
      this.clearSelect(this.subjectSelectTarget, []);
    }
  }

  populateSelect(selectElement, items) {
    selectElement.innerHTML = '<option value="">Выберите...</option>';
    items.forEach(item => {
      const option = document.createElement('option');
      option.value = item.id;
      option.textContent = item.name;
      selectElement.appendChild(option);
    });
  }

  clearSelect(selectElement) {
    selectElement.innerHTML = '<option value="">Выберите...</option>';
  }
}
