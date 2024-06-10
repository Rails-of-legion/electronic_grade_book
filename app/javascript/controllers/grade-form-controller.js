// grade-form-controller.js

import { Controller } from "@hotwired/stimulus";
import { Toast } from "bootstrap";
export default class extends Controller {
  static targets = [
    "subject",
    "recordBook",
    "date",
    "value",
    "messageContainer",
  ];
  static values = {
    groupId: Number,
    recordBooks: Array,
    subjects: Array,
  };

  connect() {
    this.subjectsValue.forEach((subject) => {
      const option = document.createElement("option");
      option.value = subject.id;
      option.text = subject.name;
      this.subjectTarget.add(option);
    });
    this.toast = new Toast(document.getElementById('copyToast'));
    const today = new Date().toISOString().slice(0, 10);
    this.dateTarget.value = today;
  }

  submit(event) {
    this.toast.show()
    event.preventDefault();

    const subjectId = parseInt(this.subjectTarget.value);
    const recordBookId = parseInt(this.recordBookTarget.value);
    const date = this.dateTarget.value;
    const value = parseInt(this.valueTarget.value);

    const data = {
      grade: {
        group_id: this.groupIdValue,
        record_book_id: recordBookId,
        subject_id: subjectId,
        date: date,
        grade: value,
        is_retake: false,
      },
    };
    fetch('/grades', { 
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
        Accept: "application/json",
      },
      body: JSON.stringify(data),
    })
      .then((response) => {
        if (response.ok) {
          this.subjectTarget.value = "";
          this.recordBookTarget.value = "";
          this.dateTarget.value = "";
          this.valueTarget.value = "";

          // Показываем сообщение об успехе:
          this.messageContainerTarget.innerHTML = "<div>Оценка успешно создана!</div>"; 
        } else {
          // Обработка ошибок
          response.json().then((errors) => {
            // ... (логика отображения ошибок в форме) 
          });
        }
      })
      .catch((error) => {
        console.error("Ошибка при создании оценки:", error);
      });
  }
}