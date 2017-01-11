class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def find_params
    params.permit(:b_material)
  end
end
