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

    pdf = Prawn::Document.new

    # Добавляем настройки для Times New Roman
    pdf.font_families.update('TimesNewRoman' => {
      normal: { file: '/usr/share/fonts/truetype/msttcorefonts/Times_New_Roman.ttf',
                                       font: 'Times-Roman' },
      bold: { file: '/usr/share/fonts/truetype/msttcorefonts/Times_New_Roman_Bold.ttf',
                                       font: 'Times-Roman,Bold' }
    })

    # Установка шрифта и размера
    pdf.font 'TimesNewRoman'

    pdf.text 'Учреждение образования', align: :center, size: 11, style: :bold
    pdf.text 'РЕСПУБЛИКАНСКИЙ ИНСТИТУТ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ»', align: :center, size: 11, style: :bold

    pdf.text "ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № 1 ", align: :center, size: 11, style: :bold
    pdf.text 'аттестации вне учебной группы', align: :center, size: 11, style: :bold

    pdf.text "Отчет по экзамену: #{@exam.name}", size: 20, style: :bold
    pdf.move_down 10
    pdf.text "Название предмета: #{@exam.subject.name}"
    pdf.move_down 10
    pdf.text "Дата выставления оценки: #{@exam.date}"
    pdf.move_down 10
    pdf.text "Количество слушателей: #{@grades.count}"
    pdf.move_down 10
    pdf.text "Преподаватели, закрепленные за экзаменом: #{@exam.teacher.first_name} #{@exam.teacher.last_name}"
    pdf.move_down 10
    pdf.text "Количество слушателей, которые сдали экзамен: #{@passed_students.count}"
    pdf.move_down 10
    pdf.text "Количество слушателей, не сдавших экзамен: #{@failed_students.count}"
    pdf.move_down 20

    pdf.text "Список студентов, не явившихся или получивших отрицательный балл:", style: :bold

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

    send_data pdf.render, filename: "report.pdf", type: 'application/pdf', disposition: 'attachment'

  end

  private

  def failed_students_table_data
    [['ФИО', 'Оценка']] +
    @failed_students.map do |grade|
      student = grade.record_book.user
      ["#{student.last_name} #{student.first_name}", grade.grade || 'Не явился']
    end
  end
end
