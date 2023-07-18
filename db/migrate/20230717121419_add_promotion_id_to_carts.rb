# frozen_string_literal: true

class AddPromotionIdToCarts < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :promotion_id, :integer
  end
end
