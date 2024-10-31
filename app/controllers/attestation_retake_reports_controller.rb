class AttestationRetakeReportsController < ApplicationController
  def select
    @attestations = IntermediateAttestation.all
    @groups = Group.all
  end

  def generate_report
    @exam = IntermediateAttestation.find(params[:exam_id])
    @group = Group.find(params[:group_id])
    report_date = @exam.date
    record_books = RecordBook.where(group_id: @group.id)
    student_ids_with_record_books = record_books.pluck(:user_id)
    @grades = Grade.joins(:record_book)
                   .where(record_books: { group_id: @group.id }, date: report_date, subject_id: @exam.subject_id)
    student_ids_with_grades = @grades.joins(:record_book).pluck('record_books.user_id').uniq
    student_ids_without_grades = student_ids_with_record_books - student_ids_with_grades
    record_books_for_students_without_grades = RecordBook.where(user_id: student_ids_without_grades, group_id: @group.id)
    @grades += record_books_for_students_without_grades.map do |record_book|
      Grade.new(record_book: record_book, date: report_date, subject_id: @exam.subject_id, grade: nil)
    end
    @passed_students = @grades.select { |grade| grade.grade.to_i >= 4 }
  @failed_students = @grades.select { |grade| grade.grade.nil? || grade.grade.to_i < 3 }

    respond_to do |format|
      format.pdf do
        pdf_data = generate_pdf_report
        send_data pdf_data, filename: 'report.pdf', type: 'application/pdf', disposition: 'attachment'
      end

      format.docx do
        docx_data = generate_docx_report
        send_data docx_data, filename: 'report.docx', type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', disposition: 'attachment'
      end
    end
  end

  private

  def generate_pdf_report
    pdf = Prawn::Document.new
    pdf.font_families.update('TimesNewRoman' => {
                               normal: { file: 'app/assets/fonts/Inter.ttf' },
                               bold: { file: 'app/assets/fonts/Inter.ttf' }
                             })
    pdf.font 'TimesNewRoman'

    pdf.text 'Учреждение образования', align: :center, size: 11, style: :bold
    pdf.text 'РЕСПУБЛИКАНСКИЙ ИНСТИТУТ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ»', align: :center, size: 11, style: :bold

    pdf.text 'ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № 1 ', align: :center, size: 11, style: :bold
    pdf.text 'аттестации вне учебной группы', align: :center, size: 11, style: :bold

    pdf.text "Отчет по экзамену: #{@exam.name}", size: 20, style: :bold
    pdf.move_down 10
    pdf.text "Название предмета: #{@exam.subject.name}"
    pdf.move_down 10
    pdf.text "Дата выставления оценки: #{@exam.date.strftime('%d.%m.%Y')}"
    pdf.move_down 10
    pdf.text "Количество слушателей: #{@grades.count}"
    pdf.move_down 10
    pdf.text "Преподаватели, закрепленные за экзаменом: #{@exam.teacher.last_name} #{@exam.teacher.first_name}"
    pdf.move_down 10
    pdf.text "Количество слушателей, которые сдали экзамен: #{@passed_students.count}"
    pdf.move_down 10
    pdf.text "Количество слушателей, не сдавших экзамен: #{@failed_students.count}"
    pdf.move_down 10
    pdf.text 'Список студентов, не явившихся или получивших отрицательный балл:', style: :bold
    pdf.table failed_students_table_data, header: true, cell_style: { inline_format: true }
    pdf.move_down 10                         
    pdf.text "Дата выдачи ведомости: #{Time.zone.today.strftime('%d.%m.%Y')}", align: :left, size: 11
    pdf.text 'Ведомость действительна по: ________________', align: :left, size: 11
    pdf.text 'Отметка: ___________________                                                 Дата аттестации: _____________',
             align: :left, size: 11
    pdf.text 'Подпись преподавателя', align: :left, size: 11
    pdf.text '_________________________                                            ______________________ '
    pdf.text '(подпись)                                                                                   (фамилия, инициалы)'
    pdf.move_down 10
    pdf.text 'С индивидуальными сроками текущей аттестации ознакомлен', align: :left, size: 11
    pdf.move_down 10
    pdf.text '___________20___               ______________                               _______________________',
             align: :left, size: 11
    pdf.text '(дата)                                     (подпись)                               (Фамилия, инициалы слушателя)',
             align: :left, size: 11
    pdf.move_down 10
    pdf.text 'Декан факультета повышения                                                 ', align: :left, size: 11
    pdf.text "квалификации и переподготовки кадров                      _________________               <u>#{User.first.format_full_name}<u>",
             align: :left, inline_format: true, size: 11
    pdf.render
  end

  def generate_docx_report
    Caracal::Document.save("tmp/individual_report.docx") do |doc|
      doc.p 'Учреждение образования', style: 'heading'
      doc.p 'РЕСПУБЛИКАНСКИЙ ИНСТИТУТ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ', style: 'heading'

      doc.p "ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № 1", style: 'heading'
      doc.p 'аттестации вне учебной группы', style: 'heading'

      doc.p "Отчет по экзамену: #{@exam.name}", size: 20, bold: true
      doc.p "Название предмета: #{@exam.subject.name}"
      doc.p "Дата выставления оценки: #{@exam.date.strftime('%d.%m.%Y')}"
      doc.p "Количество слушателей: #{@grades.count}"
      doc.p "Преподаватели, закрепленные за экзаменом: #{@exam.teacher.last_name} #{@exam.teacher.first_name}"
      doc.p "Количество слушателей, которые сдали экзамен: #{@passed_students.count}"
      doc.p "Количество слушателей, не сдавших экзамен: #{@failed_students.count}"
      
      doc.p 'Список студентов, не явившихся или получивших отрицательный балл:', bold: true

      doc.table failed_students_table_data
      
      doc.p "Дата выдачи ведомости: #{Time.zone.today.strftime('%d.%m.%Y')}"
      doc.p 'Ведомость действительна по: ________________'
      doc.p 'Отметка: ___________________               Дата аттестации: _____________'
      doc.p 'Подпись преподавателя'
      doc.p '_________________________           ________________________'
      doc.p '(подпись)                                     (фамилия, инициалы)'
      doc.p 'С индивидуальными сроками текущей аттестации ознакомлен'
      doc.p '___________20___               ______________           _______________________'
      doc.p '(дата)                           (подпись)                         (Фамилия, инициалы слушателя)'
      doc.p 'Декан факультета повышения'
      doc.p "квалификации и переподготовки кадров  _________________    #{User.first.format_full_name}"
    end

    File.read("tmp/individual_report.docx")
  end

  def failed_students_table_data
    [%w[ФИО Оценка]] +
      @failed_students.map do |grade|
        student = grade.record_book.user
        ["#{student.last_name} #{student.first_name} #{student.middle_name}", grade.grade.nil? ? 'Не явился' : grade.grade]
      end
  end
end
