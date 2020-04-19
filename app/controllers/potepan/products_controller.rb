class Potepan::ProductsController < ApplicationController
  MAX_DISPLAY_NUMBER = 4
  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.related_products(MAX_DISPLAY_NUMBER)
  end
end
