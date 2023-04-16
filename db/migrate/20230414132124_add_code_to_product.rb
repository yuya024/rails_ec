# frozen_string_literal: true

class AddCodeToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :code, :string, null: false, default: ''
  end
end
