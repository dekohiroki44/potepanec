class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.related_products(4)
  end
end
