class OrdersController < ApplicationController
  def index
  end

  def create
    @order = Order.new(order_params)
    @cart_items = current_cart.cart_items.includes(:product)
    @total_price = current_cart.total_price
    @cities = params[:country_id].blank? ? [] : City.where(country_id: params[:country_id])

    if @cart_items.blank?
      flash.now[:alert] = "カートに商品を入れてください"
      render "carts/index", status: :unprocessable_entity
    else
      if Order.order_process(order: @order, current_cart_items: @cart_items)
        session[:cart_id] = nil
        flash[:notice] = "購入ありがとうございます"
        redirect_to root_path
      else
        render "carts/index", status: :unprocessable_entity
      end
    end
  end

  def city_list
    @cities = params[:order][:country_id].blank? ? [] : City.where(country_id: params[:order][:country_id])
    render json: { cities: @cities }
  end

  private

  def order_params
    params.require(:order).permit(:last_name, :first_name, :user_name, :email_address, :postal_code, :address, :mansion_name,
    :card_name, :card_number, :card_expiration, :card_cvv).merge(params.permit(:country_id, :city_id))
  end
end
