# app/controllers/retakes_controller.rb
class RetakesController < ApplicationController
  before_action :set_retake, only: %i[show edit update destroy]

  def index
    @retakes = Retake.all
  end

  def show; end

  def new
    @retake = Retake.new
  end

  def edit; end

  def create
    @retake = Retake.new(retake_params)
    if @retake.save
      redirect_to @retake, notice: 'Retake was successfully created.'
    else
      render :new
    end
  end

  def update
    if @retake.update(retake_params)
      redirect_to @retake, notice: 'Retake was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @retake.destroy
    redirect_to retakes_url, notice: 'Retake was successfully destroyed.'
  end

  private

  def set_retake
    @retake = Retake.find(params[:id])
  end

  def retake_params
    params.require(:retake).permit(:subject_id, :student_id, :date, :grade_id, :date)
  end
end
