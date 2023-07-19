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
    elsif @promotion.used?
      flash.now[:alert] = '入力されたコードは無効です'
      render 'carts/index', status: :unprocessable_entity
    elsif Order.order_process(order: @order, current_cart_items: @cart_items)
      order_successful
    else
      @error_messages = @order.errors.full_messages.reject do |m|
        str = %w[Country City]
        m.include?(str[0]) || m.include?(str[1])
      end
      render 'carts/index', status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def promotion_apply
    promotion = Promotion.find_by(code: params[:code])
    total_price = current_cart.total_price
    current_cart.update!(promotion_id: nil)

    if current_cart.cart_items.includes(:product).blank?
      promotion = params[:code]
      message = 'カートに商品を入れてください'
      render json: { promotion:, message:, total_price: }
    elsif promotion.blank? || promotion.used == true
      promotion = params[:code]
      message = '入力されたコードは無効です'
      render json: { promotion:, message:, total_price: }
    else
      set_current_promotion(promotion:)
      render json: { promotion:, total_price: }
    end
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
              :country_id, :city_id, :promotion_id
            ))
  end

  def set_view_variables
    @order = Order.new(order_params)
    @promotion = Promotion.find_or_initialize_by(id: params[:promotion_id])
    @cart_items = current_cart.cart_items.includes(:product)
    @total_price = if @promotion.discount.blank?
                     current_cart.total_price
                   else
                     [current_cart.total_price - @promotion.discount, 0].max
                   end
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
