class MarksReport
  def self.generate_pdf(record_book_id, retake_count)
    pdf = Prawn::Document.new
    pdf.font_families.update('TimesNewRoman' => {
                               normal: { file: '/usr/share/fonts/truetype/msttcorefonts/Times_New_Roman.ttf',
                                         font: 'Times-Roman' },
                               bold: { file: '/usr/share/fonts/truetype/msttcorefonts/Times_New_Roman_Bold.ttf',
                                       font: 'Times-Roman,Bold' }
                             })

    pdf.font 'TimesNewRoman'

    pdf.text 'Marks Report', align: :center, size: 12, style: :bold

    font 'TimesNewRoman'

    # Заголовок
    text 'Учреждение образования', align: :center, size: 11, style: :bold
    text 'РЕСПУБЛИКАНСКИЙ ИНСТИТУТ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ»', align: :center, size: 11, style: :bold

    # Информация о ведомости
    text "ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № #{intermediate_attestation.id} ", align: :center, size: 11, style: :bold
    text 'аттестации вне учебной группы', align: :center, size: 11, style: :bold
    move_down 5

    text "Студент #{record_book.users.name}", align: :left, size: 11
    # Информация о дисциплине
    text "Средний балл студента: #{grades.where(record_book_id: record_book_id).average(:mark)}", align: :left,
                                                                                                  size: 11
    # Информация о форме обучения и аттестации
    text "Количество пересдач: #{retake_count}", align: :left, size: 11

    pdf.render
    pdf.to_blob
  end
end
