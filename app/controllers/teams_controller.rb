class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: %i[show update destroy]
  before_action :authorize_admin_or_manager, only: %i[index create update destroy]
  before_action :authorize_admin, only: [:show]

  def index
    @teams = Team.all
    render json: @teams, include: { users: { only: %i[id email role] } }
  end

  def show
    render json: @team, include: { users: { only: %i[id email role] } }
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      render json: @team, status: :created, location: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  def update
    if @team.update(team_params)
      render json: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @team.destroy
    head :no_content
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :manager_id)
  end

  def authorize_admin_or_manager
    render json: { error: 'Not authorized' }, status: :forbidden unless current_user.admin? || current_user.manager?
  end

  def authorize_admin
    render json: { error: 'Not authorized' }, status: :forbidden unless current_user.admin?
  end
end
