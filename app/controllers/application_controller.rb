# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_cart

  private

  def current_cart
    current_cart = Cart.find_by(id: session[:cart_id]) || Cart.create
    session[:cart_id] ||= current_cart.id
    Cart.find(session[:cart_id])
  end

  def current_promotion
    Promotion.find_by(id: session[:promotion_id])
  end

  def set_current_promotion(promotion:)
    session[:promotion_id] = promotion.id
  end
end
