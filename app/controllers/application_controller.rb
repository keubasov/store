class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def find_params
    params.permit([:b_material, :childs])
  end

  def head_word

    return 'Детское' if params[:childs]
    return case params[:b_material]
             when 'unbleached_calico'
               'Бязь'
             when 'poplin'
               'Поплин'
             when 'sateen'
               'Сатин'
             else
               'Бязь'
           end
  end
end
