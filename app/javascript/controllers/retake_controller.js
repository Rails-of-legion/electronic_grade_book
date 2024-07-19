import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="retake"
export default class extends Controller {
  static targets = ["attestationSelect", "groupSelect"];

  connect() {
    this.attestationSelectTarget.addEventListener("change", this.fetchGroups.bind(this));
  }

  fetchGroups() {
    const attestationId = this.attestationSelectTarget.value;
    if (attestationId) {
      fetch(`/intermediate_attestations/${attestationId}/groups.json`)
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json();
        })
        .then(data => {
          const groups = data || [];
          this.populateSelect(this.groupSelectTarget, groups);
        })
        .catch(error => {
          console.error('Error fetching groups:', error);
        });
    } else {
      this.populateSelect(this.groupSelectTarget, []);
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
}
