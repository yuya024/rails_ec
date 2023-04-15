# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])

    @related_products = Product.get_related_product(params[:id])
  end
end
