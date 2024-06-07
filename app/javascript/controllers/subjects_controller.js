import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["specialization", "group", "recordBook", "intermediateAttestation", "user"];

  connect() {
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
  
    if (groupId) {
      const url = `/record_books.json?group_id=${groupId}`;
      fetch(url)
        .then((response) => response.json())
        .then((recordBooks) => {
          this.populateSelectRecordBook(this.recordBookTarget, recordBooks); 
        });
    } else {
      this.clearSelect(this.recordBookTarget);
    }
  }

  updateIntermediateAttestations() {
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

  populateSelectRecordBook(selectElement, items, nestedKey = null) {
    selectElement.innerHTML = "";
    selectElement.innerHTML += `<option value="">Выберите...</option>`; 
    items.forEach((item) => {
      const user = item.user
      const value = item.id;
      const name = user ? ( user.last_name + ' ' + user.first_name  + ' ' + user.middle_name) : "Без пользователя"; 
      selectElement.innerHTML += `<option value="${value}">${name}</option>`;
    });
}

  clearSelect(selectElement) {
    selectElement.innerHTML = `<option value="">Выберите...</option>`;
  }
}