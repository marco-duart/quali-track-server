class EvaluationQuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_evaluation_question, only: %i[show update destroy]

  def index
    @evaluation_questions = EvaluationQuestion.all
    render json: @evaluation_questions
  end

  def show
    render json: @evaluation_question
  end

  def create
    @evaluation_question = EvaluationQuestion.new(evaluation_question_params)
    if @evaluation_question.save
      render json: @evaluation_question, status: :created
    else
      render json: @evaluation_question.errors, status: :unprocessable_entity
    end
  end

  def update
    if @evaluation_question.update(evaluation_question_params)
      render json: @evaluation_question
    else
      render json: @evaluation_question.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @evaluation_question.destroy
    head :no_content
  end

  private

  def set_evaluation_question
    @evaluation_question = EvaluationQuestion.find(params[:id])
  end

  def evaluation_question_params
    params.require(:evaluation_question).permit(:evaluation_id, :question_id)
  end
end
