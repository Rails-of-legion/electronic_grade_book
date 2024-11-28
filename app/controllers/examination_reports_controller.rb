class ExaminationReportsController < ApplicationController
   
  def index
    @pagy, @examination_reports =pagy ExaminationReport.order(created_at: :desc)
  end
  
  def new
      @examination_report=ExaminationReport.new
  end
   
   def create
      @examination_report = ExaminationReport.new(examination_report_params)
      if @examination_report.save
        redirect_to @examination_report, notice: 'Отчет успешно создан.'
      else
        render :new
      end
   end

   def edit
    @examination_report = ExaminationReport.find(params[:id])
   end
   
   def update
    @examination_report = ExaminationReport.find(params[:id])
    if @examination_report.update(examination_report_params)
      redirect_to @examination_report, notice: 'Отчет успешно обновлен.'
    else
      render :edit
    end
   end
   def show
    @examination_report = ExaminationReport.find(params[:id])
   end

   def destroy
    @examination_report = ExaminationReport.find(params[:id])
    @examination_report.destroy
    redirect_to examination_reports_path, notice: 'Отчет успешно удален.'
   end
   
   private

   def examination_report_params
     params.require(:examination_report).permit(:group, :subject, :attestation, :teacher, :student, :mark, :date_of_attestation, :date_until_valid,:date_of_statement)
   end
 
end
