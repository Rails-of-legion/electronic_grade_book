class AttestationRetakeReportsController < ApplicationController
  def select
    @attestations = IntermediateAttestation.all
    @groups = Group.all
  end

  def generate_report
    @exam = IntermediateAttestation.find(params[:exam_id])
    @group = Group.find(params[:group_id])
    @grades = @exam.grades.includes(record_book: :user).where(record_books: { group_id: @group.id })
    @passed_students = @grades.select { |grade| grade.grade >= 4 }
    @failed_students = @grades.select { |grade| grade.grade < 3 || grade.grade.nil? }

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
    pdf.text "Дата выставления оценки: #{@exam.date}"
    pdf.move_down 10
    pdf.text "Количество слушателей: #{@grades.count}"
    pdf.move_down 10
    pdf.text "Преподаватели, закрепленные за экзаменом: #{@exam.teacher.last_name} #{@exam.teacher.first_name}"
    pdf.move_down 10
    pdf.text "Количество слушателей, которые сдали экзамен: #{@passed_students.count}"
    pdf.move_down 10
    pdf.text "Количество слушателей, не сдавших экзамен: #{@failed_students.count}"
    pdf.move_down 20

    pdf.text 'Список студентов, не явившихся или получивших отрицательный балл:', style: :bold

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

    pdf.table failed_students_table_data, header: true

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
      doc.p "Дата выставления оценки: #{@exam.date}"
      doc.p "Количество слушателей: #{@grades.count}"
      doc.p "Преподаватели, закрепленные за экзаменом: #{@exam.teacher.last_name} #{@exam.teacher.first_name}"
      doc.p "Количество слушателей, которые сдали экзамен: #{@passed_students.count}"
      doc.p "Количество слушателей, не сдавших экзамен: #{@failed_students.count}"
      
      doc.p 'Список студентов, не явившихся или получивших отрицательный балл:', bold: true

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

      doc.table failed_students_table_data
    end

    File.read("tmp/individual_report.docx")
  end

  def failed_students_table_data
    [%w[ФИО Оценка]] +
      @failed_students.map do |grade|
        student = grade.record_book.user
        ["#{student.last_name} #{student.first_name}", grade.grade || 'Не явился']
      end
  end
end
