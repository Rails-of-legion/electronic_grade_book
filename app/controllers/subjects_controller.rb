class SubjectsController < ApplicationController
  before_action :set_subject, only: %i[show edit update destroy]
  load_and_authorize_resource
  def index
    subjects = current_user.student? ? student_subjects : teacher_subjects
    subjects = search_subjects(subjects)

    @pagy, @subjects = pagy(subjects, items: 10)
    nil unless current_user.teacher?
  end

  def show; end

  def new
    @subject = Subject.new
  end

  def edit; end

  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to subject_url(@subject), notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to subject_url(@subject), notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subject.destroy

    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def student_subjects
    record_book = current_user.record_book
    record_book ? record_book.group.specialization.subjects : []
  end

  def teacher_subjects
    Subject.all
  end

  def search_subjects(subjects)
    return subjects unless params[:search].present?

    search_query = "%#{params[:search].downcase}%"
    subjects.where('LOWER(name) LIKE ? OR LOWER(description) LIKE ?', search_query, search_query)
  end

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:name, :description, :semester_id)
  end
end
