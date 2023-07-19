# frozen_string_literal: true

class CartItemsController < ApplicationController
  ITEM_COUNT = 1

  def create
    if current_cart.add_items(product_id: params[:product_id], quantity: params[:quantity] || ITEM_COUNT)
      flash[:notice] = "#{params[:product_name]}を追加しました"
    end
    # 遷移元の判定
    redirect_to params[:index].present? ? products_path : product_path(params[:product_id])
  end

  def destroy
    flash[:notice] = "#{params[:product_name]}をカートから削除しました" if current_cart.delete_item(product_id: params[:product_id])

    if current_cart.cart_items.blank? && current_promotion.present?
      flash[:notice] << "\nまたカートに商品がないためコードは無効となりました"
      current_cart.update!(promotion_id: nil)
    end
    redirect_to carts_path
  end
end
