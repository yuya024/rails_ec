# frozen_string_literal: true

class CartsController < ApplicationController
  def index
    @cart_items = current_cart.cart_items.includes(:product)
    @cities = []
    @order = Order.new
    if current_promotion.present?
      @promotion = current_promotion
      @total_price = [current_cart.total_price - @promotion.discount, 0].max
    else
      @promotion = Promotion.new
      @total_price = current_cart.total_price
    end
  end
end
