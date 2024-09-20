class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: %i[show update destroy]
  before_action :authorize_admin_monitor, only: %i[create update destroy deactivate]

  def index
    @questions = Question.where(active: true)
    render json: @questions
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

  def deactivate
    @question.update(active: false)
    render json: { message: 'Question successfully disabled.' }
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :description, :score, :active)
  end

  def authorize_admin_monitor
    return unless current_user.admin? || current_user.monitor?

    render json: { error: 'Not authorized' },
           status: :forbidden
  end
end
