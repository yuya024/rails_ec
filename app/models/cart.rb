# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def add_items(product_id:, quantity:)
    item = cart_items.find_by(product_id:) || cart_items.create(product_id:)
    item.quantity += quantity.to_i
    item.save
  end

  def total_price
    items = cart_items.includes(:product)
    items.sum('quantity*price')
  end

  def delete_item(product_id:)
    cart_items.find_by(product_id:).destroy
  end
end
