class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show destroy]
  before_action :authorize_admin, only: %i[index destroy]
  before_action :authorize_admin_or_manager_or_monitor, only: [:show]

  def index
    @users = User.all
    render json: @users, except: [:encrypted_password]
  end

  def show
    render json: @user, except: [:encrypted_password]
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_admin
    render json: { error: 'Not authorized' }, status: :forbidden unless current_user.admin?
  end

  def authorize_admin_or_manager_or_monitor
    return if current_user.admin? || current_user.manager? || current_user.monitor?

    render json: { error: 'Not authorized' }, status: :forbidden
  end
end
