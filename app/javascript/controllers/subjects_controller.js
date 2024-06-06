import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["specialization", "group", "recordBook", "intermediateAttestation"];

  connect() {
    console.log("SubjectsController: connected"); // Лог при подключении
    this.updateGroups();
    this.updateIntermediateAttestations();
  }

  change() {
    console.log("SubjectsController: change event"); // Лог при изменении
    this.updateGroups();
    this.updateRecordBooks();
    this.updateIntermediateAttestations();
  }

  updateGroups() {
    console.log("SubjectsController: updating groups"); // Лог при обновлении групп
    const specializationId = this.specializationTarget.value;
    const url = `/groups.json?specialization_id=${specializationId}`;

    fetch(url)
      .then((response) => response.json())
      .then((groups) => {
        this.groupTarget.innerHTML = "";
        this.groupTarget.innerHTML += `<option value="">Выберите группу</option>`;
        groups.forEach((group) => {
          this.groupTarget.innerHTML += `<option value="${group.id}">${group.name}</option>`;
        });
        this.recordBookTarget.innerHTML = "";
        this.recordBookTarget.innerHTML += `<option value="">Выберите студента</option>`;
      });
  }

  updateRecordBooks() {
    console.log("SubjectsController: updating record books"); // Лог при обновлении списка студентов
    const groupId = this.groupTarget.value;
    if (groupId) { 
      const url = `/record_books.json?group_id=${groupId}`;

      fetch(url)
        .then((response) => response.json())
        .then((recordBooks) => {
          this.recordBookTarget.innerHTML = "";
          this.recordBookTarget.innerHTML += `<option value="">Выберите студента</option>`;
          recordBooks.forEach((recordBook) => {
            this.recordBookTarget.innerHTML += `<option value="${recordBook.user_id}">${recordBook.user.name}</option>`;
          });
        });
    }
  }

  updateIntermediateAttestations() {
    console.log("SubjectsController: updating intermediate attestations"); // Лог при обновлении аттестаций
    const specializationId = this.specializationTarget.value;
    const url = `/intermediate_attestations.json?specialization_id=${specializationId}`;

    fetch(url)
      .then((response) => response.json())
      .then((intermediateAttestations) => {
        this.intermediateAttestationTarget.innerHTML = "";
        this.intermediateAttestationTarget.innerHTML += `<option value="">Выберите промежуточную аттестацию</option>`;
        intermediateAttestations.forEach((ia) => {
          this.intermediateAttestationTarget.innerHTML += `<option value="${ia.id}">${ia.name}</option>`;
        });
      });
  }
}
