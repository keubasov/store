class CatalogController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: :index
  def index
    @looks = Look.where(find_params).order(:name)
    @head_word = head_word
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @look = Look.find(params[:id])
  end

  def add_to_cart

  end
end
