class CatalogController < ApplicationController

  def index
    @looks = Look.where(find_params).order(:name)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @look = Look.find(params[:id])
  end
end
