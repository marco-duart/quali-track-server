class DepartmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_department, only: %i[show update destroy]
  before_action :authorize_admin, only: %i[index create update destroy]

  def index
    @departments = Department.all
    render json: @departments, include: { users: { only: %i[id email role] } }
  end

  def show
    render json: @department, include: { users: { only: %i[id email role] } }
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      render json: @department, status: :created, location: @department
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  def update
    if @department.update(department_params)
      render json: @department
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @department.destroy
    head :no_content
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name)
  end

  def authorize_admin
    render json: { error: 'Not authorized' }, status: :forbidden if current_user.admin?
  end
end
