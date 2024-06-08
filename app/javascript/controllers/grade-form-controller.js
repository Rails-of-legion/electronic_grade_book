// grade-form-controller.js

import { Controller } from "@hotwired/stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = [
    "subject",
    "recordBook",
    "date",
    "value",
    "messageContainer",
  ]; //  Добавлен messageContainer 
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
  }

  submit(event) {
    event.preventDefault();

    const subjectId = parseInt(this.subjectTarget.value);
    const recordBookId = parseInt(this.recordBookTarget.value);
    const date = this.dateTarget.value;
    const value = parseInt(this.valueTarget.value);

    // Валидация (если нужна)
    // ...

    const data = {
      grade: {
        group_id: this.groupIdValue,
        record_book_id: recordBookId,
        subject_id: subjectId,
        date: date,
        value: value,
      },
    };

    fetch(Rails.routes.grades_path(), { 
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
          // Очистка формы:
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