class SpecialitiesSubjectsController < ApplicationController
    before_action :set_specialities_subject, only: %i[show edit update destroy]
  
    def index
      @specialities_subjects = SpecialitiesSubject.all
    end
  
    def show; end
  
    def new
      @specialities_subject = SpecialitiesSubject.new
    end
  
    def edit; end
  
    def create
      @specialities_subject = SpecialitiesSubject.new(specialities_subject_params)
  
      if @specialities_subject.save
        redirect_to @specialities_subject, notice: 'Specialities subject was successfully created.'
      else
        render :new
      end
    end
  
    def update
      if @specialities_subject.update(specialities_subject_params)
        redirect_to @specialities_subject, notice: 'Specialities subject was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @specialities_subject.destroy
      redirect_to specialities_subjects_url, notice: 'Specialities subject was successfully destroyed.'
    end
  
    private
  
    def set_specialities_subject
      @specialities_subject = SpecialitiesSubject.find(params[:id])
    end
  
    def specialities_subject_params
      params.require(:specialities_subject).permit(:specialization_id, :subject_id)
    end
  end
  