prawn_document title: 'Inermediate attestation Report' do |pdf|
pdf.font_families.update("TimesNewRoman" => {
    :normal => { :file => "/usr/share/fonts/truetype/msttcorefonts/Times_New_Roman.ttf", :font => "Times-Roman" },
    :bold => { :file => "/usr/share/fonts/truetype/msttcorefonts/Times_New_Roman_Bold.ttf", :font => "Times-Roman,Bold" } 
  })
  pdf.font 'TimesNewRoman', size: 11
  pdf.text "Учреждение образования"
  pdf.text "РЕСПУБЛИКАНСКИЙ ИНСТИТУТ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ"
  pdf.text "ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № 1"
  pdf.text "Группа #{@intermediate_attestation.group.name}"
  pdf.text "#{@intermediate_attestation.group.specialization.id} #{@intermediate_attestation.group.specialization.name}" 
  pdf.text "Учебная дисциплина, модуль «#{@intermediate_attestation.subject.name}»"
  pdf.text "Форма получения образования #{@intermediate_attestation.group.form_of_education}"
  pdf.text "Форма промежуточной аттестации #{@intermediate_attestation.name}"
  pdf.text "Всего часов и зачетных единиц по учебной дисциплине, модулю  1"
  pdf.text "Преподаватель #{@intermediate_attestation.teacher.name}"

  table_data = [['№ пп', 'Фамилия, собственное имя, отчество слушателя', 'Отметка', 'Подпись преподавателя']]

  pdf.text "Студент: #{@intermediate_attestation.record_books.users.name.first}"

  pdf.table table_data

  pdf.text "Количество слушателей, присутствовавших на аттестации"
  pdf.text "Количество слушателей, получивших отметки:"
  table_grades = [['10','','9','','8','','7',''],
                    ['6','','5','','4','','3',''],
                    ['2','','1','','','','',''],
                    ['зачтено','','не зачтено','']]
  pdf.table table_grades
  pdf.text "Количество слушателей, не явившихся на аттестацию"
  pdf.text "Подпись преподавателя"
  pdf.text "Декан факультета повышения квалификации и переподготовки кадров"
end
