class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_from_error

  def rescue_from_error(exception)
    redirect_to root_url
  end
end
