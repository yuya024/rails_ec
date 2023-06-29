# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :basic_auth, only: %i[index show]

  def index
    @orders = Order.includes(:order_items)
  end

  def create
    set_view_variables

    if @cart_items.blank?
      flash.now[:alert] = 'カートに商品を入れてください'
      render 'carts/index', status: :unprocessable_entity
    elsif Order.order_process(order: @order, current_cart_items: @cart_items)
      order_successful
    else
      render 'carts/index', status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def city_list
    @cities = params[:order][:country_id].blank? ? [] : City.where(country_id: params[:order][:country_id])
    render json: { cities: @cities }
  end

  private

  def order_params
    params.require(:order).permit(
      :last_name, :first_name, :user_name, :email_address, :postal_code, :address, :mansion_name,
      :card_name, :card_number, :card_expiration, :card_cvv
    ).merge(params.permit(
              :country_id, :city_id
            ))
  end

  def set_view_variables
    @order = Order.new(order_params)
    @cart_items = current_cart.cart_items.includes(:product)
    @total_price = current_cart.total_price
    @cities = params[:country_id].blank? ? [] : City.where(country_id: params[:country_id])
  end

  def order_successful
    session[:cart_id] = nil
    CheckoutMailer.checkout_email(@order).deliver_now
    flash[:notice] = '購入ありがとうございます'
    redirect_to root_path
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == 'pw'
    end
  end
end
