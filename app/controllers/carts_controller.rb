# frozen_string_literal: true

class CartsController < ApplicationController
  def index
    @cart_items = current_cart.cart_items.includes(:product)
    @total_price = current_cart.total_price
    @cities = []
    @order = Order.new
  end
end
