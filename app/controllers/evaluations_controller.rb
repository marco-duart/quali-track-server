class EvaluationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_evaluation, only: %i[show update destroy]
  before_action :authorize_admin_or_manager_or_monitor, only: %i[index show create update destroy]

  def index
    @evaluations = Evaluation.includes(:questions, :answers, :critical_fields, :employee, :monitor, :team).all
    render json: @evaluations.as_json(include: {
                                        questions: { include: :answers },
                                        critical_fields: { only: %i[description penalty_percentage] },
                                        employee: { only: %i[id email] },
                                        monitor: { only: %i[id email] },
                                        team: { only: %i[id name] }
                                      })
  end

  def show
    render json: @evaluation.as_json(include: {
                                       questions: { include: :answers },
                                       critical_fields: { only: %i[description penalty_percentage] },
                                       employee: { only: %i[id email] },
                                       monitor: { only: %i[id email] },
                                       team: { only: %i[id name] }
                                     })
  end

  def create
    @evaluation = Evaluation.new(evaluation_params)
    if @evaluation.save
      render json: @evaluation, status: :created, location: @evaluation
    else
      render json: @evaluation.errors, status: :unprocessable_entity
    end
  end

  def update
    if @evaluation.update(evaluation_params)
      render json: @evaluation
    else
      render json: @evaluation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @evaluation.destroy
    head :no_content
  end

  private

  def set_evaluation
    @evaluation = Evaluation.find(params[:id])
  end

  def evaluation_params
    params.require(:evaluation).permit(:name, :user_id, :team_id, :monitor_id,
                                       questions_attributes: %i[id content weight _destroy],
                                       critical_fields_attributes: %i[id description penalty_percentage _destroy])
  end

  def authorize_admin_or_manager_or_monitor
    return unless current_user.admin? || current_user.manager? || current_user.monitor?

    render json: { error: 'Not authorized' },
           status: :forbidden
  end
end
