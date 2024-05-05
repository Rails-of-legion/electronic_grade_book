prawn_document title: 'Inermediate attestation Report' do |pdf|
pdf.font_families.update("TimesNewRoman" => {
    :normal => { :file => "/usr/share/fonts/truetype/msttcorefonts/Times_New_Roman.ttf", :font => "Times-Roman" },
    :bold => { :file => "/usr/share/fonts/truetype/msttcorefonts/Times_New_Roman_Bold.ttf", :font => "Times-Roman,Bold" } 
  })
  pdf.font 'TimesNewRoman', size: 11
  pdf.bounds.add_left_padding(72)

  pdf.text "Учреждение образования", align: :center, style: :bold
  pdf.text "РЕСПУБЛИКАНСКИЙ ИНСТИТУТ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ", align: :center, style: :bold
  pdf.text "ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № #{@intermediate_attestation.id}", align: :center, style: :bold
  pdf.text_box "Группа #{@intermediate_attestation.group.name}",
              at: [0, pdf.cursor],
              width: pdf.bounds.width / 2,
              align: :left
  pdf.move_down 10
  pdf.text_box "Дата проведения #{@intermediate_attestation.date}",
              at: [pdf.bounds.width / 2, pdf.cursor],
              width: pdf.bounds.width / 2,
              align: :right
  pdf.text "#{@intermediate_attestation.group.specialization.id} #{@intermediate_attestation.group.specialization.name}", align: :justify 
  pdf.text "Учебная дисциплина, модуль «#{@intermediate_attestation.subject.name}»", align: :justify
  pdf.text "Форма получения образования #{@intermediate_attestation.group.form_of_education}", align: :justify
  pdf.text "Форма промежуточной аттестации #{@intermediate_attestation.name}", align: :justify
  pdf.text "Всего часов и зачетных единиц по учебной дисциплине, модулю  1", align: :justify
  pdf.text "Преподаватель #{@intermediate_attestation.teacher.name}", align: :justify

  table_data = [['№ пп', 'Фамилия, собственное имя, отчество слушателя', 'Отметка', 'Подпись преподавателя']]

RecordBook.all.each_with_index do |record_book, index|
  grades = record_book.grades.map(&:grade).join(', ') # Получаем оценки из связанных объектов Grade и объединяем их в строку
  table_data << [index + 1, record_book.user.name, grades, '']
end

pdf.table(table_data, header: true)
pdf.move_down 10


  pdf.text "Количество слушателей, присутствовавших на аттестации  "
  pdf.text "Количество слушателей, получивших отметки:"
  table_grades = [['10','','9','','8','','7',''],
                    ['6','','5','','4','','3',''],
                    ['2','','1','','','','',''],
                    ['зачтено','','не зачтено','']]

  pdf.table(table_grades, width: pdf.bounds.width) do
  cells.style(width: pdf.bounds.width / table_grades[0].size)
  end
  pdf.move_down 10
  pdf.text "Количество слушателей, не явившихся на аттестацию"
  pdf.move_down 10

  pdf.text_box "Подпись преподавателя",
              at: [0, pdf.cursor],
              width: pdf.bounds.width / 2,
              align: :left
  pdf.move_down 10
  pdf.text_box "______________",
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
  pdf.text_box "______________",
              at: [pdf.bounds.width / 4, pdf.cursor],
              width: pdf.bounds.width / 2,
              align: :center
  pdf.move_down 10
  pdf.text_box "Декан Декан Декан",
              at: [pdf.bounds.width / 2, pdf.cursor],
              width: pdf.bounds.width / 2,
              align: :right


end
