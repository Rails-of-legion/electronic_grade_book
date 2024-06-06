import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["specialization", "group", "recordBook", "intermediateAttestation"];

  connect() {
    console.log("SubjectsController: connected");
    this.updateGroups();
    this.updateIntermediateAttestations();
  }

  change() {
    console.log("SubjectsController: change event");
    this.updateGroups();
    this.updateRecordBooks();
    this.updateIntermediateAttestations();
  }

  updateGroups() {
    console.log("SubjectsController: updating groups");
    const specializationId = this.specializationTarget.value;
    if (specializationId) {
      const url = `/groups.json?specialization_id=${specializationId}`;
      fetch(url)
        .then((response) => response.json())
        .then((groups) => {
          this.populateSelect(this.groupTarget, groups);
          this.clearSelect(this.recordBookTarget);
          this.updateRecordBooks();
        });
    } else {
      this.clearSelect(this.groupTarget);
      this.clearSelect(this.recordBookTarget);
    }
  }
  

  updateRecordBooks() {
    console.log("SubjectsController: updating record books");
    const groupId = this.groupTarget.value;
    console.log(groupId)
    console.log('updateRecordBooks')
    if (groupId) {
      const url = `/record_books.json?group_id=${groupId}`;
      console.log('if')
      fetch(url)
        .then((response) => response.json())
        .then((recordBooks) => {
          this.populateSelect(this.recordBookTarget, recordBooks);
        });
    } else {
      console.log('else')
      this.clearSelect(this.recordBookTarget);
    }
  }

  updateIntermediateAttestations() {
    console.log("SubjectsController: updating intermediate attestations");
    const specializationId = this.specializationTarget.value;
    if (specializationId) {
      const url = `/intermediate_attestations.json?specialization_id=${specializationId}`;
      fetch(url)
        .then((response) => response.json())
        .then((intermediateAttestations) => {
          this.populateSelect(this.intermediateAttestationTarget, intermediateAttestations);
        });
    } else {
      this.clearSelect(this.intermediateAttestationTarget);
    }
  }

  populateSelect(selectElement, items, nestedKey = null) {
    selectElement.innerHTML = "";
    selectElement.innerHTML += `<option value="">Выберите...</option>`; 
    items.forEach((item) => {
      const value = nestedKey ? item[nestedKey].id : item.id;
      const name = nestedKey ? item[nestedKey].name : item.name;
      selectElement.innerHTML += `<option value="${value}">${name}</option>`;
    });
  }

  clearSelect(selectElement) {
    selectElement.innerHTML = `<option value="">Выберите...</option>`;
  }
}