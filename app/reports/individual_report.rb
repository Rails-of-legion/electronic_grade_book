require 'caracal'

class IndividualReport
  def self.generate_pdf(intermediate_attestation_id, record_book_id)
    intermediate_attestation = IntermediateAttestation.find(intermediate_attestation_id)
    record_book = RecordBook.includes(:user).find(record_book_id)

    Prawn::Document.new do
      # font_families.update('TimesNewRoman' => {
      #                        normal: { file: '/app/app/assets/fonts/Inter.ttf',
      #                                  font: 'Times-Roman' },
      #                        bold: { file: '/app/app/assets/fonts/Inter.ttf',
      #                                font: 'Times-Roman,Bold' }
      #                      })
      font_families.update('TimesNewRoman' => {
                             normal: { file: 'app/assets/fonts/Inter.ttf' },
                             bold: { file: 'app/assets/fonts/Inter.ttf' }
                           })

      # Установка шрифта и размера
      font 'TimesNewRoman'

      # Заголовок
      text 'Учреждение образования', align: :center, size: 11, style: :bold
      text 'РЕСПУБЛИКАНСКИЙ ИНСТИТУТ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ»', align: :center, size: 11, style: :bold

      # Информация о ведомости
      text "ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № #{intermediate_attestation.id} ", align: :center, size: 11, style: :bold
      text 'аттестации вне учебной группы', align: :center, size: 11, style: :bold
      move_down 5

      # Информация о группе и специальности
      indent(40) do
        text "Группа № #{record_book.group.name}", align: :left, size: 11
        text "«#{intermediate_attestation.groups.name} #{intermediate_attestation.groups.name}»",
             align: :left, size: 11
        # Информация о дисциплине
        text "Учебная дисциплина: #{intermediate_attestation.subject.name}", align: :left, size: 11
        # Информация о форме обучения и аттестации
        text "Форма получения образования: #{intermediate_attestation.groups.name}", align: :left, size: 11
        text "Форма промежуточной аттестации: #{intermediate_attestation.name}", align: :left, size: 11
        # Объем дисциплины
        text 'Всего часов и зачетных единиц по учебной дисциплине: ', align: :left, size: 11
        # Преподаватель (заглушка, замените на данные из базы)
        text "Преподаватель: #{intermediate_attestation.teacher.name}", align: :left, size: 11
        text "Фамилия, инициалы слушателя: #{record_book.user.name}", align: :left, size: 11

        # Даты и подписи (заглушки)
        text "Дата выдачи ведомости: #{Time.zone.today.strftime('%d.%m.%Y')}", align: :left, size: 11
        text 'Ведомость действительна по: ________________', align: :left, size: 11
        text 'Отметка: ___________________                                                 Дата аттестации: _____________',
             align: :left, size: 11
        text 'Подпись преподавателя', align: :left, size: 11
        text '_________________________                                            ______________________ '
        text '(подпись)                                                                                   (фамилия, инициалы)'
        move_down 10
        text 'С индивидуальными сроками текущей аттестации ознакомлен', align: :left, size: 11
        move_down 10
        text '___________20___               ______________                               _______________________',
             align: :left, size: 11
        text '(дата)                                     (подпись)                               (Фамилия, инициалы слушателя)',
             align: :left, size: 11
        move_down 10
        text 'Декан факультета повышения                                                 ', align: :left, size: 11
        text "квалификации и переподготовки кадров                      _________________               <u>#{User.first.format_full_name}<u>",
             align: :left, inline_format: true, size: 11
      end
    end.render
  end

  def self.generate_docx(intermediate_attestation_id, record_book_id)
    intermediate_attestation = IntermediateAttestation.find(intermediate_attestation_id)
    record_book = RecordBook.includes(:user).find(record_book_id)

    Caracal::Document.save("tmp/individual_report.docx") do |doc|
      
      doc.p 'Учреждение образования', style: 'heading'
      doc.p 'РЕСПУБЛИКАНСКИЙ ИНСТИТУТ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ', style: 'heading'

      doc.p "ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № #{intermediate_attestation.id}", style: 'heading'
      doc.p 'аттестации вне учебной группы', style: 'heading'

      doc.p "Группа № #{record_book.group.name}"
      doc.p "«#{intermediate_attestation.groups.name} #{intermediate_attestation.groups.name}»"
      doc.p "Учебная дисциплина: #{intermediate_attestation.subject.name}"
      doc.p "Форма получения образования: #{intermediate_attestation.groups.name}"
      doc.p "Форма промежуточной аттестации: #{intermediate_attestation.name}"
      doc.p 'Всего часов и зачетных единиц по учебной дисциплине: '
      doc.p "Преподаватель: #{intermediate_attestation.teacher.name}"
      doc.p "Фамилия, инициалы слушателя: #{record_book.user.name}"
      doc.p "Дата выдачи ведомости: #{Time.zone.today.strftime('%d.%m.%Y')}"
      doc.p 'Ведомость действительна по: ________________'
      doc.p 'Отметка: ___________________               Дата аттестации: _____________'
      doc.p 'Подпись преподавателя'
      doc.p '_________________________           ________________________'
      doc.p '(подпись)                                     (фамилия, инициалы)'
      doc.p 'С индивидуальными сроками текущей аттестации ознакомлен'
      doc.p '___________20___       ________________      _______________________'
      doc.p '(дата)                             (подпись)                    (Фамилия, инициалы слушателя)'
      doc.p 'Декан факультета повышения квалификации и переподготовки кадров'
      doc.p "#{User.first.format_full_name}"
    end

    File.read("tmp/individual_report.docx")
  end
end

  private

  def student_data_table
    [['Фамилия, инициалы слушателя', @student.name]]
  end

  def generate_document_number
    # Замените на логику генерации номера документа
    '24-001'
  end
