class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  private

  def record_not_unique
    render json: { error: 'Email has already been taken' }, status: :unprocessable_entity
  end
end
