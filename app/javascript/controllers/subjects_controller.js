// app/javascript/controllers/subjects_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "specialization", 
    "group", 
    "recordBook", 
    "intermediateAttestation"
  ]
  initialize() {
    console.log('con')
  }
  change(event) {
    const target = event.target;
    const nextTarget = this.getNextTarget(target);

    if (nextTarget) {
      this.enableSelect(nextTarget);
    }
  }

  getNextTarget(current) {
    switch (current) {
      case this.specializationTarget:
        return this.groupTarget;
      case this.groupTarget:
        return this.recordBookTarget;
      case this.recordBookTarget:
        return this.intermediateAttestationTarget;
      default:
        return null;
    }
  }

  enableSelect(select) {
    select.disabled = false;
  }
}
