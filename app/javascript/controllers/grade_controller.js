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
    console.log(event.target.selectedOptions[0].value)
    this.updateFieldsState()
  }

  changeSubject(event) {
    console.log(event.target.selectedOptions[0].value)
    const dateSelect = this.hasDateSelectTarget ? this.dateSelectTarget : null
    const gradeSelect = this.hasGradeSelectTarget ? this.gradeSelectTarget : null
    const recordBookSelect = this.hasRecordBookSelectTarget ? this.recordBookSelectTarget : null
    const formTeacher = this.hasFormTeacherTarget ? this.formTeacherTarget : null
  
    // Получаем значения month и subject_id
    const month = document.getElementById('month-select').value
    const subjectId = event.target.value
  
    // Обновляем атрибуты элемента formTeacher
    formTeacher.setAttribute('data-month', month)
    formTeacher.setAttribute('data-subject-id', subjectId)
  
    if (subjectId) {
      if (dateSelect) dateSelect.disabled = false
      if (gradeSelect) gradeSelect.disabled = false
      if (recordBookSelect) recordBookSelect.disabled = false
      if (formTeacher) formTeacher.style.display = 'block'
    } else {
      if (dateSelect) dateSelect.disabled = true
      if (gradeSelect) gradeSelect.disabled = true
      if (recordBookSelect) recordBookSelect.disabled = true
      if (formTeacher) formTeacher.style.display = 'none'
    }
    
    this.reloadFormTeacher();
  }

  reloadFormTeacher() {
    const monthValue = document.getElementById('month-select').value;
    const subjectValue = this.subjectSelectTarget.value;
    
    if (monthValue && subjectValue) {
      const formTeacherContainer = this.formTeacherTarget;
      const url = `/grades/update_form_teacher?month=${monthValue}&subject_id=${subjectValue}`;

      fetch(url)
        .then(response => response.text())
        .then(html => {
          formTeacherContainer.innerHTML = html;
        })
        .catch(error => console.error('Error reloading form teacher:', error));
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
