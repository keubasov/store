class CatalogController < ApplicationController

  def index
    @products = Product.order(:name)
    @product_names = Product.names
  end
end
