require 'rails_helper'
require 'prawn'
require 'caracal'

RSpec.describe IndividualReport, type: :model do
  let!(:subject) { create(:subject) }

  describe '.generate_pdf' do
    let!(:student) { create(:user) }
    let!(:teacher) { create(:user, role_name: 'teacher') }
    let!(:intermediate_attestation) { create(:intermediate_attestation, subject: create(:subject), teacher: teacher) }
    let!(:record_book) { create(:record_book, student: student, teacher: teacher, intermediate_attestation: intermediate_attestation) }
    it 'generates a PDF with the correct content' do
      pdf_content = IndividualReport.generate_pdf(intermediate_attestation.id, record_book.id)

      # Проверка содержания PDF
      io = StringIO.new(pdf_content)
      pdf = Prawn::Document.new(io: io)
      text = pdf.pages.first.text

      expect(text).to include('Учреждение образования')
      expect(text).to include("ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № #{intermediate_attestation.id}")
      expect(text).to include("Группа: № #{record_book.group.name}") if record_book.group
      expect(text).to include("Специальность: #{record_book.specialization.name}") if record_book.specialization
      expect(text).to include("Учебная дисциплина: #{intermediate_attestation.subject.name}")
      expect(text).to include("Форма получения образования: #{record_book.group.form_of_education}") if record_book.group
      expect(text).to include("Форма промежуточной аттестации: #{intermediate_attestation.name}")
      expect(text).to include("Преподаватель: #{intermediate_attestation.teacher.name}")
      expect(text).to include("Фамилия, инициалы слушателя: #{record_book.student.name}")
      expect(text).to include("Дата выдачи ведомости: #{Time.zone.today.strftime('%d.%m.%Y')}")
    end
  end

  describe '.generate_docx' do
    let!(:student) { create(:user) }
    let!(:teacher) { create(:user, role_name: 'teacher') }
    let!(:intermediate_attestation) { create(:intermediate_attestation, subject: create(:subject), teacher: teacher) }
    let!(:record_book) { create(:record_book, student: student, teacher: teacher, intermediate_attestation: intermediate_attestation) }
    it 'generates a DOCX file with the correct content' do
      docx_content = IndividualReport.generate_docx(intermediate_attestation.id, record_book.id)

      # Проверка содержания DOCX файла
      temp_file = Tempfile.new(['individual_report', '.docx'])
      temp_file.write(docx_content)
      temp_file.rewind

      doc = Caracal::Document.open(temp_file.path)
      text = doc.paragraphs.map(&:text).join("\n")

      expect(text).to include('Учреждение образования')
      expect(text).to include("ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ № #{intermediate_attestation.id}")
      expect(text).to include("Группа № #{record_book.group.name}") if record_book.group
      expect(text).to include("Специальность: #{record_book.specialization.name}") if record_book.specialization
      expect(text).to include("Учебная дисциплина: #{intermediate_attestation.subject.name}")
      expect(text).to include("Форма получения образования: #{record_book.group.form_of_education}") if record_book.group
      expect(text).to include("Форма промежуточной аттестации: #{intermediate_attestation.name}")
      expect(text).to include("Преподаватель: #{intermediate_attestation.teacher.name}")
      expect(text).to include("Фамилия, инициалы слушателя: #{record_book.student.name}")
      expect(text).to include("Дата выдачи ведомости: #{Time.zone.today.strftime('%d.%m.%Y')}")
    ensure
      temp_file.close
      temp_file.unlink
    end
  end
end
