import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["month", "subject", "formTeacher"];
  static values = { group: Number, specialization: Number };

  connect() {
    this.fetchSubjects();
    this.formTeacherTarget.addEventListener('click', this.handleClickOnCell.bind(this));
  }

  monthTargetConnected() {
    this.monthTarget.addEventListener("change", this.fetchSubjects.bind(this))
  }

  subjectTargetConnected() {
    this.subjectTarget.addEventListener("change", this.fetchForm.bind(this))
  }

  fetchSubjects() {
    const month = this.monthTarget.value;

    if (this.groupValue) {
      const url = `/groups/${this.groupValue}/subjects`;

      fetch(url)
        .then((response) => response.json())
        .then((subjects) => {
          this.populateSelect(this.subjectTarget, subjects);
        });
    } else {
      this.clearSelect(this.subjectTarget);
    }
  }

  populateSelect(selectElement, items) {
    selectElement.innerHTML = '<option value="">Выберите...</option>';
    items.forEach((item) => {
      const option = document.createElement('option');
      option.value = item.id;
      option.text = item.name;
      selectElement.add(option);
    });
  }

  clearSelect(selectElement) {
    selectElement.innerHTML = '<option value="">Выберите...</option>';
  }

  fetchForm() {
    const groupId = this.groupValue;
    const month = this.monthTarget.value;
    const subjectId = this.subjectTarget.value;

    if (month && subjectId) {
      fetch(`/groups/${groupId}/form_teacher?month=${month}&subject_id=${subjectId}`)
        .then(response => response.text())
        .then(html => {
          this.formTeacherTarget.innerHTML = html;
        });
    } else {
      this.formTeacherTarget.innerHTML = "";
    }
  }

  handleClickOnCell(event) {
    const cell = event.target.closest('td');

    if (cell && !cell.querySelector('input')) {
      const day = cell.cellIndex + 1; // Adjusted to match day index (1-based)
      const recordBookId = cell.parentNode.dataset.recordBookId;
      const existingGrade = cell.textContent.trim();

      if (day && recordBookId) {
        this.createGradeInput(cell, recordBookId, day, existingGrade);
      }
    }
  }

  createGradeInput(cell, recordBookId, day, existingGrade) {
    const input = document.createElement('input');
    input.type = 'number';
    input.min = '1';
    input.max = '10';
    input.classList.add('form-control', 'grade-input');
    input.value = existingGrade;

    input.addEventListener('keydown', (event) => {
      if (event.key === 'Enter') {
        const grade = input.value.trim();
        if (grade === "") {
          this.deleteGrade(recordBookId, day);
          cell.textContent = '';
        } else if (grade >= 1 && grade <= 10) {
          this.saveGrade(grade, recordBookId, day, existingGrade);
          cell.textContent = grade;
        } else {
          alert('Оценка должна быть от 1 до 10');
        }
      }
    });

    input.addEventListener('blur', () => {
      input.remove();
    });

    cell.textContent = '';
    cell.appendChild(input);
    input.focus();
  }

  saveGrade(grade, recordBookId, day, existingGrade) {
    const month = this.monthTarget.value;
    const subjectId = this.subjectTarget.value;

    // Ensure correct month index
    const correctMonth = parseInt(month, 10) - 1;
    const date = new Date(new Date().getFullYear(), correctMonth, day).toISOString();

    const data = {
      grade: {
        date: date,
        subject_id: subjectId,
        record_book_id: recordBookId,
        grade: grade
      }
    };

    fetch('/grades/find', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        date: date,
        subject_id: subjectId,
        record_book_id: recordBookId
      })
    })
    .then(response => response.json())
    .then(existingGrade => {
      if (existingGrade) {
        this.updateGrade(existingGrade.id, data);
      } else {
        this.createGrade(data);
      }
    });
  }

  deleteGrade(recordBookId, day) {
    const month = this.monthTarget.value;
    const subjectId = this.subjectTarget.value;

    // Ensure correct month index
    const correctMonth = parseInt(month, 10) - 1;
    const date = new Date(new Date().getFullYear(), correctMonth, day).toISOString();

    fetch('/grades/find', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        date: date,
        subject_id: subjectId,
        record_book_id: recordBookId
      })
    })
    .then(response => response.json())
    .then(existingGrade => {
      if (existingGrade) {
        fetch(`/grades/${existingGrade.id}`, {
          method: 'DELETE',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
          }
        }).then(response => {
          if (response.ok) {
            console.log('Grade deleted:', existingGrade);
          }
        });
      }
    });
  }

  createGrade(data) {
    const grade = data.grade.grade;
    if (grade >= 1 && grade <= 10) {
    fetch('/grades', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify(data)
    }).then(response => {
      if (response.ok) {
        response.json().then(newGrade => {
          console.log('Grade created:', newGrade);
          this.refreshGradeInTable(newGrade);
        });
      }
    });
  } else {
    alert('Оценка должна быть от 1 до 10');
  }
}

  updateGrade(existingGradeId, data) {
    const grade = data.grade.grade;
    if (grade >= 1 && grade <= 10) {
    fetch(`/grades/${existingGradeId}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify(data)
    }).then(response => {
      if (response.ok) {
        response.json().then(updatedGrade => {
          console.log('Grade updated:', updatedGrade);
          this.refreshGradeInTable(updatedGrade);
        });
      }
    });
  } else {
    alert('Оценка должна быть от 1 до 10');
  }
}

  refreshGradeInTable(grade) {
    const cell = this.findCellForGrade(grade);
    if (cell) {
      cell.textContent = grade.grade;
    }
  }

  findCellForGrade(grade) {
    const row = document.querySelector(`tr[data-record-book-id='${grade.record_book_id}']`);
    if (row) {
      const date = new Date(grade.date);
      const day = date.getDate();
      return row.cells[day];
    }
    return null;
  }
}
