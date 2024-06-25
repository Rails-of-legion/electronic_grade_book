import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["month", "subject", "formTeacher"]
  static values = { group: Number, specialization: Number }

  connect() {
    console.log("Report controller connected");
    console.log("Group ID:", this.groupValue);
    console.log("Specialization ID:", this.specializationValue);
    this.fetchSubjects();
    this.formTeacherTarget.addEventListener('click', this.handleClickOnCell.bind(this));
  }

  monthTargetConnected() {
    console.log("Month target connected");
    this.monthTarget.addEventListener("change", this.fetchSubjects.bind(this))
  }

  subjectTargetConnected() {
    this.subjectTarget.addEventListener("change", this.fetchForm.bind(this))
  }

  fetchSubjects() {
    console.log("Fetching subjects...");
    const month = this.monthTarget.value;
    console.log("Selected month:", month);

    if (this.groupValue) {
      const url = `/groups/${this.groupValue}/subjects`;
      console.log("Fetching from URL:", url);

      fetch(url)
        .then((response) => {
          return response.json();
        })
        .then((subjects) => {
          console.log("Received subjects:", subjects);
          this.populateSelect(this.subjectTarget, subjects);
        })
        .catch(error => {
          console.error("Error fetching subjects:", error);
        });

    } else {
      console.warn("Group ID is not available. Cannot fetch subjects.");
      this.clearSelect(this.subjectTarget);
    }
  }

  populateSelect(selectElement, items) {
    console.log("Populating select element with items:", items);
    selectElement.innerHTML = '<option value="">Выберите...</option>';
    items.forEach((item) => {
      const option = document.createElement('option');
      option.value = item.id;
      option.text = item.name;
      selectElement.add(option);
    });
  }

  clearSelect(selectElement) {
    console.log("Clearing select element");
    selectElement.innerHTML = '<option value="">Выберите...</option>';
  }

  fetchForm() {
    const groupId = this.groupValue
    const month = this.monthTarget.value
    const subjectId = this.subjectTarget.value

    if (month && subjectId) {
      fetch(`/groups/${groupId}/form_teacher?month=${month}&subject_id=${subjectId}`)
        .then(response => response.text())
        .then(html => {
          this.formTeacherTarget.innerHTML = html
        })
    } else {
      this.formTeacherTarget.innerHTML = ""
    }
  }

  handleClickOnCell(event) {
    const cell = event.target.closest('td');

    if (cell && !cell.querySelector('input')) {
      const day = cell.cellIndex;
      const recordBookId = cell.parentNode.dataset.recordBookId;

      if (day && recordBookId) {
        this.createGradeInput(cell, recordBookId, day);
      }
    }
  }

  createGradeInput(cell, recordBookId, day) {
    const input = document.createElement('input');
    input.type = 'number';
    input.min = '1';
    input.max = '5';
    input.classList.add('form-control', 'grade-input');

    input.addEventListener('blur', () => {
      this.saveGrade(input.value, recordBookId, day);
      cell.textContent = input.value ? input.value : '';
      input.remove();
    });

    cell.textContent = '';
    cell.appendChild(input);
    input.focus();
  }

  saveGrade(grade, recordBookId, day) {
    const month = this.monthTarget.value;
    const subjectId = this.subjectTarget.value;
    
    // Убедитесь, что месяц передается правильно (от 0 до 11)
    const correctMonth = parseInt(month, 10) - 1;
    
    // Создаем дату в локальном формате для клиента
    const date = new Date(new Date().getFullYear(), correctMonth, day).toLocaleDateString();
    
    const data = {
      grade: {
        date: date,
        subject_id: subjectId,
        record_book_id: recordBookId,
        grade: grade
      }
    };
    
    fetch('/grades', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify(data)
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
      console.log('Grade saved:', data);
    })
    .catch(error => {
      console.error('Error saving grade:', error);
    });
  }  
}
