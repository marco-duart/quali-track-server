class CriticalFieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_critical_field, only: %i[show update destroy]
  before_action :authorize_admin_or_manager_or_monitor

  def index
    @critical_fields = CriticalField.all
    render json: @critical_fields
  end

  def show
    render json: @critical_field
  end

  def create
    @critical_field = CriticalField.new(critical_field_params)
    if @critical_field.save
      render json: @critical_field, status: :created, location: @critical_field
    else
      render json: @critical_field.errors, status: :unprocessable_entity
    end
  end

  def update
    if @critical_field.update(critical_field_params)
      render json: @critical_field
    else
      render json: @critical_field.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @critical_field.destroy
    head :no_content
  end

  private

  def set_critical_field
    @critical_field = CriticalField.find(params[:id])
  end

  def critical_field_params
    params.require(:critical_field).permit(:description, :penalty_percentage, :evaluation_id)
  end

  def authorize_admin_or_manager_or_monitor
    return unless current_user.admin? || current_user.manager? || current_user.monitor?

    render json: { error: 'Not authorized' },
           status: :forbidden
  end
end
