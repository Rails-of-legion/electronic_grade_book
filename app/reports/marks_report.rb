class MarksReport
  def self.generate_pdf(record_book_id, retake_count)
    pdf = Prawn::Document.new
    pdf.font_families.update('TimesNewRoman' => {
                               normal: { file: 'app/assets/fonts/Inter.ttf' },
                               bold: { file: 'app/assets/fonts/Inter.ttf' }
                             })

    pdf.font 'TimesNewRoman'

    pdf.text 'Отчет о задолженностях', align: :center, size: 12, style: :bold

    # Заголовок
    pdf.text 'Учреждение образования', align: :center, size: 11, style: :bold
    pdf.text 'РЕСПУБЛИКАНСКИЙ ИНСТИТУТ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ', align: :center, size: 11, style: :bold

    # Информация о ведомости
    # Здесь предполагается, что у вас есть метод intermediate_attestation для получения id
    pdf.text 'ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № 1', align: :center, size: 11, style: :bold
    pdf.text 'аттестации вне учебной группы', align: :center, size: 11, style: :bold
    pdf.move_down 5

    # Получение данных о студенте и оценках
    record_book = RecordBook.find(record_book_id)
    user_name = record_book.user.name
    average_grade = Grade.where(record_book_id: record_book_id).average(:grade)

    pdf.text "Студент #{user_name}", align: :left, size: 11
    pdf.text "Средний балл студента: #{average_grade}", align: :left, size: 11
    pdf.text "Количество пересдач: #{retake_count}", align: :left, size: 11

    pdf.text 'Подпись преподавателя', align: :left, size: 11
    pdf.text '_________________________                                            ______________________ '
    pdf.text '(подпись)                                                                                   (фамилия, инициалы)'
    pdf.text 'С индивидуальными сроками текущей аттестации ознакомлен', align: :left, size: 11
    pdf.text '___________20___               ______________                               _______________________',
             align: :left, size: 11
    pdf.text '(дата)                                     (подпись)                               (Фамилия, инициалы слушателя)',
             align: :left, size: 11
    pdf.text 'Декан факультета повышения                                                 ', align: :left, size: 11
    pdf.text "квалификации и переподготовки кадров                       _________________               <u>#{User.first.format_full_name}<u>",
             align: :left, inline_format: true, size: 11

    pdf.render
  end

  def self.generate_docx(record_book_id, retake_count)
    record_book = RecordBook.includes(:user).find(record_book_id)
    user_name = record_book.user.name
    average_grade = Grade.where(record_book_id: record_book_id).average(:grade)
    Caracal::Document.save('tmp/marks_report.docx') do |doc|
      doc.p 'Отчет о задолженностях', style: 'heading', align: 'center'
      doc.p 'Учреждение образования', style: 'heading', align: 'center'
      doc.p 'РЕСПУБЛИКАНСКИЙ ИНСТИТУТ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ', style: 'heading', align: 'center'
      doc.p 'ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № 1', style: 'heading', align: 'center'
      doc.p 'аттестации вне учебной группы', style: 'heading', align: 'center'

      doc.p "Студент #{user_name}", style: 'normal'
      doc.p "Средний балл студента: #{average_grade}", style: 'normal'
      doc.p "Количество пересдач: #{retake_count}", style: 'normal'

      doc.p 'Подпись преподавателя', style: 'normal'
      doc.p '_________________________                                            ______________________ ', style: 'normal'
      doc.p '(подпись)                                                                                   (фамилия, инициалы)', style: 'normal'
      doc.p 'С индивидуальными сроками текущей аттестации ознакомлен', style: 'normal'
      doc.p '___________20___               ______________                               _______________________', style: 'normal'
      doc.p '(дата)                                     (подпись)                               (Фамилия, инициалы слушателя)', style: 'normal'
      doc.p 'Декан факультета повышения                                                 ', style: 'normal'
      doc.p "квалификации и переподготовки кадров                       _________________               #{User.first.format_full_name}", style: 'normal'
    end

    File.read('tmp/marks_report.docx')
  end        
end

