class SignaturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_signature, only: %i[show update destroy]
  before_action :authorize_admin_or_manager_or_monitor

  def index
    @signatures = Signature.all
    render json: @signatures
  end

  def show
    render json: @signature
  end

  def create
    @signature = Signature.new(signature_params)
    if @signature.save
      render json: @signature, status: :created, location: @signature
    else
      render json: @signature.errors, status: :unprocessable_entity
    end
  end

  def update
    if @signature.update(signature_params)
      render json: @signature
    else
      render json: @signature.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @signature.destroy
    head :no_content
  end

  private

  def set_signature
    @signature = Signature.find(params[:id])
  end

  def signature_params
    params.require(:signature).permit(:status, :evaluation_id, :user_id, :manager_id, :employee_id)
  end

  def authorize_admin_or_manager_or_monitor
    return unless current_user.admin? || current_user.manager? || current_user.monitor?

    render json: { error: 'Not authorized' },
           status: :forbidden
  end
end
