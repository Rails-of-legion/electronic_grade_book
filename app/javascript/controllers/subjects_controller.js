import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["specialization", "group", "recordBook", "intermediateAttestation"];

  connect() {
    console.log("SubjectsController: connected");
    this.updateAll();
  }

  change() {
    console.log("SubjectsController: change event");
    this.updateAll();
  }

  updateAll() {
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
        .then(this.handleFetchResponse)
        .then((groups) => {
          this.populateSelect(this.groupTarget, groups);
          this.clearSelect(this.recordBookTarget);
          this.updateRecordBooks();
        })
        .catch(this.handleFetchError);
    } else {
      this.clearSelect(this.groupTarget);
      this.clearSelect(this.recordBookTarget);
    }
  }

  updateRecordBooks() {
    console.log("SubjectsController: updating record books");
    const groupId = this.groupTarget.value;
    if (groupId) {
      const recordBooksUrl = `/record_books.json?group_id=${groupId}`;

      fetch(recordBooksUrl)
        .then(this.handleFetchResponse)
        .then((recordBooks) => {
          console.log("Fetched recordBooks:", recordBooks);

          if (Array.isArray(recordBooks) && recordBooks.length > 0 && recordBooks[0].user) {
            this.populateSelect(this.recordBookTarget, recordBooks, 'user');
          } else {
            console.log("No user property found in recordBooks or recordBooks is empty");
            this.clearSelect(this.recordBookTarget);
          }
        })
        .catch(this.handleFetchError);
    } else {
      this.clearSelect(this.recordBookTarget);
    }
  }

  updateIntermediateAttestations() {
    console.log("SubjectsController: updating intermediate attestations");
    const specializationId = this.specializationTarget.value;
    if (specializationId) {
      const url = `/intermediate_attestations.json?specialization_id=${specializationId}`;
      fetch(url)
        .then(this.handleFetchResponse)
        .then((intermediateAttestations) => {
          this.populateSelect(this.intermediateAttestationTarget, intermediateAttestations);
        })
        .catch(this.handleFetchError);
    } else {
      this.clearSelect(this.intermediateAttestationTarget);
    }
  }

  populateSelect(selectElement, items, nestedKey = null) {
    selectElement.innerHTML = "";
    selectElement.innerHTML += `<option value="">Выберите...</option>`;
    items.forEach((item) => {
      console.log("Processing item:", item);
      const value = nestedKey ? item[nestedKey].id : item.id;
      const name = nestedKey ? `${item[nestedKey].last_name} ${item[nestedKey].first_name} ${item[nestedKey].middle_name}` : item.name;
      selectElement.innerHTML += `<option value="${value}">${name}</option>`;
    });
  }

  clearSelect(selectElement) {
    selectElement.innerHTML = `<option value="">Выберите...</option>`;
  }

  handleFetchResponse(response) {
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    return response.json();
  }

  handleFetchError(error) {
    console.error('Fetch error:', error);
  }
}
