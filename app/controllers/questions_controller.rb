class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: %i[show update destroy]
  before_action :authorize_admin_or_manager_or_monitor

  def index
    @questions = Question.all
    render json: @questions, include: :answers
  end

  def show
    render json: @question, include: :answers
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      render json: @question, status: :created, location: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    head :no_content
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content, :weight, :evaluation_id)
  end

  def authorize_admin_or_manager_or_monitor
    return unless current_user.admin? || current_user.manager? || current_user.monitor?

    render json: { error: 'Not authorized' },
           status: :forbidden
  end
end
