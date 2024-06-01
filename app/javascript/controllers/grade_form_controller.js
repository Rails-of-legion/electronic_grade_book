// app/javascript/controllers/grade_form_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["subjectSelect", "dateSelect", "gradeSelect", "recordBookSelect", "formTeacher"]

  connect() {
    this.updateFieldsState()
  }

  updateFieldsState() {
    const monthSelect = document.getElementById('month-select')
    const subjectSelect = this.subjectSelectTarget
    const dateSelect = this.dateSelectTarget
    const gradeSelect = this.gradeSelectTarget
    const recordBookSelect = this.recordBookSelectTarget
    const formTeacher = this.formTeacherTarget

    if (monthSelect.value) {
      subjectSelect.disabled = false
    } else {
      subjectSelect.disabled = true
      dateSelect.disabled = true
      gradeSelect.disabled = true
      recordBookSelect.disabled = true
      formTeacher.style.display = 'none'
    }

    subjectSelect.addEventListener('change', function() {
      if (subjectSelect.value) {
        dateSelect.disabled = false
        gradeSelect.disabled = false
        recordBookSelect.disabled = false
        formTeacher.style.display = 'block'
      } else {
        dateSelect.disabled = true
        gradeSelect.disabled = true
        recordBookSelect.disabled = true
        formTeacher.style.display = 'none'
      }
    })
  }
}
