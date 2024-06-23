prawn_document title: 'Intermediate Attestation Report' do |pdf|
  pdf.font_families.update("TimesNewRoman" => {
    normal: { file: "/app/app/assets/fonts/Inter.ttf" },
    bold: { file: "/app/app/assets/fonts/Inter.ttf" }
  })
  pdf.font 'TimesNewRoman', size: 11
  pdf.bounds.add_left_padding(72)
  pdf.text "Учреждение образования", align: :center, style: :bold
  pdf.text "РЕСПУБЛИКАНСКИЙ ИНСТИТУТ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ", align: :center, style: :bold
  group = @intermediate_attestation.groups.ids

  pdf.text "ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № #{@intermediate_attestation.id}", align: :center, style: :bold

  pdf.move_down 10

  pdf.text_box "Дата проведения #{@intermediate_attestation.date}",
              at: [pdf.bounds.width / 2, pdf.cursor],
              width: pdf.bounds.width / 2,
              align: :right
  @groups.each do |group|
    pdf.text "Учебная дисциплина, модуль «#{@intermediate_attestation.subject.name}»", align: :justify
    pdf.text "Группа #{group.name}", align: :justify
    pdf.text "Форма получения образования #{group.form_of_education}", align: :justify
  end
  pdf.text "Форма промежуточной аттестации #{@intermediate_attestation.name}", align: :justify
  pdf.text "Всего часов и зачетных единиц по учебной дисциплине, модулю  1", align: :justify
  pdf.text "Преподаватель #{@intermediate_attestation.teacher.name}", align: :justify

  table_data = [['№ пп', 'Фамилия, собственное имя, отчество слушателя', 'Отметка', 'Подпись преподавателя']]
# Получаем список студентов группы
students_in_group = RecordBook.includes(:group, :user)
                              .where(group_id: @intermediate_attestation.group_ids)
                              .to_a

# Получаем студентов, участвующих в аттестации
students_with_grades = students_in_group.select do |record_book|
  record_book.grades.exists?(subject_id: @intermediate_attestation.subject_id)
end

table_data = [['№ пп', 'Фамилия, собственное имя, отчество слушателя', 'Отметка', 'Подпись преподавателя']]

students_with_grades.each_with_index do |record_book, index|
  grades = record_book.grades.map(&:grade).join(', ')
  table_data << [index + 1, record_book.user.name, grades.first, '']
end

pdf.table(table_data, header: true)
pdf.move_down 10

pdf.move_down 10

# Получаем количество студентов с оценками для данной промежуточной аттестации
students_with_grades_count = RecordBook.joins(:grades)
                                      .where(grades: { subject_id: @intermediate_attestation.subject_id })
                                      .distinct.count

# Получаем общее количество студентов в группе
total_students_count = RecordBook.joins(:group)
                                  .where(groups: { id: @intermediate_attestation.group_ids })
                                  .count

students_with_grades_count = RecordBook.joins(:grades)
                                      .where(grades: { subject_id: @intermediate_attestation.subject_id })
                                      .distinct.count

# Получаем количество студентов без оценок
students_without_grades_count = total_students_count - students_with_grades_count

  pdf.text "Количество студентов, присутствовавших на аттестации: #{students_with_grades_count}"
  pdf.text "Количество слушателей, получивших отметки: #{students_with_grades_count}"
  table_grades = [['10','','9','','8','','7',''],
                    ['6','','5','','4','','3',''],
                    ['2','','1','','','','',''],
                    ['зачтено','','не зачтено','']]

  pdf.table(table_grades, width: pdf.bounds.width) do
  cells.style(width: pdf.bounds.width / table_grades[0].size)
  end
  pdf.move_down 10
  pdf.text "Количество студентов, не явившихся на аттестацию: #{students_without_grades_count}"
  pdf.move_down 10

  pdf.text_box "Подпись преподавателя",
              at: [0, pdf.cursor],
              width: pdf.bounds.width / 2,
              align: :left
  pdf.move_down 10
  pdf.text_box "                   ______________",
              at: [pdf.bounds.width / 4, pdf.cursor],
              width: pdf.bounds.width / 2,
              align: :center
  pdf.move_down 10
  pdf.text_box "#{@intermediate_attestation.teacher.name}",
              at: [pdf.bounds.width / 2, pdf.cursor],
              width: pdf.bounds.width / 2,
              align: :right

  pdf.text_box "Декан факультета повышения квалификации и переподготовки кадров",
              at: [0, pdf.cursor],
              width: pdf.bounds.width / 2,
              align: :left
  pdf.move_down 10
  pdf.text_box "                   ______________",
              at: [pdf.bounds.width / 4, pdf.cursor],
              width: pdf.bounds.width / 2,
              align: :center
  pdf.move_down 10
  pdf.text_box "#{User.first.format_full_name}",
              at: [pdf.bounds.width / 2, pdf.cursor],
              width: pdf.bounds.width / 2,
              align: :right


end
