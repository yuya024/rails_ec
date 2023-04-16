# frozen_string_literal: true

class Product < ApplicationRecord
  def self.get_related_product(product_id)
    get_ids = Product.where.not(id: product_id).pluck(:id).sample(4)
    Product.find(get_ids)
  end
end
