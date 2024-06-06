import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["subjectSelect", "dateSelect", "gradeSelect", "recordBookSelect", "formTeacher", "gradeFormContainer"]

  connect() {
    this.updateFieldsState()
  }

  updateFieldsState() {
    const monthSelect = document.getElementById('month-select')
    const subjectSelect = this.subjectSelectTarget
    const dateSelect = this.hasDateSelectTarget ? this.dateSelectTarget : null
    const gradeSelect = this.hasGradeSelectTarget ? this.gradeSelectTarget : null
    const recordBookSelect = this.hasRecordBookSelectTarget ? this.recordBookSelectTarget : null
    const formTeacher = this.hasFormTeacherTarget ? this.formTeacherTarget : null

    if (monthSelect.value) {
      subjectSelect.disabled = false
    } else {
      subjectSelect.disabled = true
      if (dateSelect) dateSelect.disabled = true
      if (gradeSelect) gradeSelect.disabled = true
      if (recordBookSelect) recordBookSelect.disabled = true
      if (formTeacher) formTeacher.style.display = 'none'
    }
  }

  change(event) {
    const subjectSelect = this.subjectSelectTarget
    const dateSelect = this.hasDateSelectTarget ? this.dateSelectTarget : null
    const gradeSelect = this.hasGradeSelectTarget ? this.gradeSelectTarget : null
    const recordBookSelect = this.hasRecordBookSelectTarget ? this.recordBookSelectTarget : null
    const formTeacher = this.hasFormTeacherTarget ? this.formTeacherTarget : null

    if (event.target.value) {
      subjectSelect.disabled = false
    } else {
      subjectSelect.disabled = true
      if (dateSelect) dateSelect.disabled = true
      if (gradeSelect) gradeSelect.disabled = true
      if (recordBookSelect) recordBookSelect.disabled = true
      if (formTeacher) formTeacher.style.display = 'none'
    }
  }

  toggleGradeForm() {
    const gradeFormContainer = this.gradeFormContainerTarget
    if (gradeFormContainer.style.display === 'none' || gradeFormContainer.style.display === '') {
      gradeFormContainer.style.display = 'block'
    } else {
      gradeFormContainer.style.display = 'none'
    }
  }
}
