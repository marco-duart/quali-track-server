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
      if params[:question_ids].present?
        params[:question_ids].each do |question_id|
          @evaluation.evaluation_questions.build(question_id:)
        end
      end

      if params[:critical_field_ids].present?
        params[:critical_field_ids].each do |critical_field_id|
          @evaluation.evaluation_critical_fields.build(critical_field_id:)
        end
      end

      @evaluation.save

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
    params.require(:evaluation).permit(:name, :user_id, :team_id, :monitor_id, :date, :comment)
  end

  def authorize_admin_or_manager_or_monitor
    return unless current_user.admin? || current_user.manager? || current_user.monitor?

    render json: { error: 'Not authorized' },
           status: :forbidden
  end
end
