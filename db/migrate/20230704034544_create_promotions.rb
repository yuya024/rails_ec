# frozen_string_literal: true

class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.string :code, null: false
      t.integer :discount, null: false
      t.boolean :used, null: false, default: false
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
