
class IndividualReport
  def initialize(student)
    @student = student
    @group = student.record_book.group
  end

  def generate_report
    Prawn::Document.new do
      font_families.update("TimesNewRoman" => {
        :normal => { :file => "/usr/share/fonts/truetype/msttcorefonts/Times_New_Roman.ttf", :font => "Times-Roman" },
        :bold => { :file => "/usr/share/fonts/truetype/msttcorefonts/Times_New_Roman_Bold.ttf", :font => "Times-Roman,Bold" }
      })
    
      # Установка шрифта и размера
      font 'TimesNewRoman'

      # Заголовок
      text "Учреждение образования", align: :center, size: 11, style: :bold
      text "РЕСПУБЛИКАНСКИЙ ИНСТИТУТ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ»", align: :center, size: 11, style: :bold

      # Информация о ведомости
      text "ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № ", align: :center, size: 11, style: :bold
      text "аттестации вне учебной группы", align: :center, size: 11, style: :bold
      move_down 5

        # Информация о группе и специальности
      indent(40) do
        text "Группа №", align: :left, size: 11
        text "«»", align: :left, size: 11
        # Информация о дисциплине
        text "Учебная дисциплина: #", align: :left, size: 11
        # Информация о форме обучения и аттестации
        text "Форма получения образования: ", align: :left, size: 11
        text "Форма промежуточной аттестации: #}", align: :left, size: 11
        # Объем дисциплины
        text "Всего часов и зачетных единиц по учебной дисциплине: ", align: :left, size: 11
        # Преподаватель (заглушка, замените на данные из базы)
        text "Преподаватель: Иванов И.И.", align: :left, size: 11
        text "Фамилия, инициалы слушателя:", align: :left, size: 11
        
        # Даты и подписи (заглушки)
        text "Дата выдачи ведомости: #{Date.today.strftime("%d.%m.%Y")}", align: :left, size: 11
        text "Ведомость действительна по: ________________", align: :left, size: 11
        text "Отметка: ___________________                                                 Дата аттестации: _____________", align: :left, size: 11
        text "Подпись преподавателя", align: :left, size: 11
        text "_________________________                                            ______________________ "
        text "(подпись)                                                                                   (фамилия, инициалы)"
        move_down 10
        text "С индивидуальными сроками текущей аттестации ознакомлен", align: :left, size: 11
        move_down 10
        text "___________20___               ______________                               _______________________", align: :left, size: 11
        text "(дата)                                     (подпись)                               (Фамилия, инициалы слушателя)", align: :left, size: 11
        move_down 10
        text "Декан факультета повышения                                                 ", align: :left, size: 11
        text "квалификации и переподготовки кадров                                        Ю.Ю.Королев", align: :left, size: 11
      end
    end.render 
  end

  private

  def student_data_table
    [["Фамилия, инициалы слушателя", @student.name]]
  end

  def generate_document_number
    # Замените на логику генерации номера документа
    "24-001"
  end
end 