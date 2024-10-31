require 'caracal'

class ReportsController < ApplicationController
  def generate_interim_report
    @intermediate_attestation = IntermediateAttestation.find(params[:intermediate_attestation_id])
    docx_file = generate_interim_report_docx(@intermediate_attestation)

    send_file docx_file, filename: 'interim_report.docx', disposition: 'attachment'
  end

  private

  def generate_interim_report_docx(intermediate_attestation)
    temp_file = Tempfile.new(['interim_report', '.docx'])

    Caracal::Document.save(temp_file.path) do |docx|

      docx.p 'Учреждение образования', align: 'center', bold: true
      docx.p 'РЕСПУБЛИКАНСКИЙ ИНСТИТУТ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ', align: 'center', bold: true

      docx.p "ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № #{intermediate_attestation.id}", align: 'center', bold: true
      

      intermediate_attestation.groups.each do |group|
        docx.p "Дата проведения: #{intermediate_attestation.date}", align: 'right'
        docx.p "Группа: #{group.name}"
        docx.p "Учебная дисциплина, модуль: «#{intermediate_attestation.subject.name}»"
        docx.p "Форма получения образования: #{group.form_of_education}"
      end
      docx.p "Форма промежуточной аттестации: #{intermediate_attestation.name}"
      docx.p "Всего часов и зачетных единиц по учебной дисциплине: #{intermediate_attestation.subject.hours} часов, #{intermediate_attestation.subject.credit_units} зачетных единиц"
      docx.p "Преподаватель: #{intermediate_attestation.teacher.name}"

      table_data = [['№ пп', 'Фамилия, собственное имя, отчество слушателя', 'Отметка', 'Подпись преподавателя']]
      students_in_group = RecordBook.includes(:group, :user)
                                    .where(group_id: intermediate_attestation.group_ids)
                                    .to_a

      students_with_grades = students_in_group.select do |record_book|
        record_book.grades.exists?(subject_id: intermediate_attestation.subject_id)
      end

      attestation_date = @intermediate_attestation.date
      
      students_with_grades.each_with_index do |record_book, index|
        filtered_grades = record_book.grades.select { |grade| grade.date.to_date == attestation_date }
        grades = filtered_grades.map(&:grade).join(', ')
        table_data << [index + 1, record_book.user.name, grades, '']
      end

      docx.table table_data, border_size: 4 do
        cell_style rows[0], height: 300, align: :center
        cell_style cols[0], width: 500, align: :center
        cell_style cols[2], width: 1200, align: :center
      end

      students_with_grades_count = RecordBook.joins(:grades)
                                             .where(grades: { subject_id: intermediate_attestation.subject_id })
                                             .distinct.count

      total_students_count = RecordBook.joins(:group)
                                       .where(groups: { id: intermediate_attestation.group_ids })
                                       .count

      students_without_grades_count = total_students_count - students_with_grades_count
      docx.p " "
      docx.p "Количество студентов, присутствовавших на аттестации: #{students_with_grades_count}"
      docx.p "Количество слушателей, получивших отметки: #{students_with_grades_count}"
      
      grade_counts = Hash.new(0)
      students_with_grades.each do |record_book|
      filtered_grades = record_book.grades.select { |grade| grade.date.to_date == attestation_date }
      filtered_grades.each do |grade|
      grade_counts[grade.grade.to_s] += 1
    end
  end

  table_grades = [['10 (десять)', grade_counts['10'],'9 (девять)', grade_counts['9'],'8 (восемь)', grade_counts['8'],'7 (семь)', grade_counts['7']],
                    ['6 (шесть)', grade_counts['6'],'5 (пять)', grade_counts['5'],'4 (четыре)', grade_counts['4'],'3 (три)', grade_counts['3']],
                    ['2 (два)', grade_counts['2'],'1 (один)', grade_counts['1'],'','','',''],
                      ['зачтено','','не зачтено','']]
 
      docx.table table_grades, border_size: 8 do
        rows.each do |row|
          cell_style row, align: :center
        end
        cols.each do |col|
          cell_style col, align: :center
        end
      end

      docx.p "Количество студентов, не явившихся на аттестацию: #{students_without_grades_count}"
      docx.p " "

      # Подпись преподавателя
      docx.p do
        text "Подпись преподавателя", align: 'left'
        text "                      ___________________                  ", align: 'center'
        text "#{intermediate_attestation.teacher.name}", align: 'right'
      end

      docx.p " "

      # Декан факультета
      docx.p "Декан факультета повышения ", align: 'left'
      docx.p do
        text "квалификации и переподготовки кадров", align: 'left'
        text "                  ___________________                  ", align: 'center'
        text "#{User.first.format_full_name}", align: 'right'
      end
    end
    temp_file.close
    temp_file.path
  end
end
