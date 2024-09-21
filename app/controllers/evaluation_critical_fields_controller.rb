class EvaluationCriticalFieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_evaluation_critical_field, only: %i[show update destroy]

  def index
    @evaluation_critical_fields = EvaluationCriticalField.all
    render json: @evaluation_critical_fields
  end

  def show
    render json: @evaluation_critical_field
  end

  def create
    @evaluation_critical_field = EvaluationCriticalField.new(evaluation_critical_field_params)
    if @evaluation_critical_field.save
      render json: @evaluation_critical_field, status: :created
    else
      render json: @evaluation_critical_field.errors, status: :unprocessable_entity
    end
  end

  def update
    if @evaluation_critical_field.update(evaluation_critical_field_params)
      render json: @evaluation_critical_field
    else
      render json: @evaluation_critical_field.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @evaluation_critical_field.destroy
    head :no_content
  end

  private

  def set_evaluation_critical_field
    @evaluation_critical_field = EvaluationCriticalField.find(params[:id])
  end

  def evaluation_critical_field_params
    params.require(:evaluation_critical_field).permit(:evaluation_id, :critical_field_id)
  end
end
