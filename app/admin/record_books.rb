ActiveAdmin.register RecordBook do
  permit_params :student_id, :teacher_id, :intermediate_attestation_id

  index do
    selectable_column
    id_column
    column :student
    column :teacher
    column :intermediate_attestation
    column 'Subjects' do |record_book|
      record_book.subjects.map(&:name).join(', ').html_safe
    end
    column :created_at
    actions
  end

  filter :student
  filter :teacher
  filter :intermediate_attestation
  filter :created_at

  form do |f|
    f.inputs do
      f.input :student
      f.input :teacher
      f.input :intermediate_attestation
      f.input :subjects, as: :check_boxes, collection: Subject.all.map { |subject| [subject.name, subject.id] }
    end
    f.actions
  end
end
