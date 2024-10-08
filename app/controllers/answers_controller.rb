class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[show update destroy]
  before_action :authorize_monitor, only: %i[show update destroy]

  def index
    @answers = Answer.all
    render json: @answers
  end

  def show
    render json: @answer
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      render json: @answer, status: :created, location: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @answer.update(answer_params)
      render json: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy
    head :no_content
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:comment, :score, :question_id, :user_id, :evaluation_id)
  end

  def authorize_monitor
    return if current_user.monitor?

    render json: { error: 'Not authorized' },
           status: :forbidden
  end
end
