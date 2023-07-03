# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :user_name, null: false
      t.string :email_address, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :mansion_name
      t.references :country, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.string :card_name, null: false
      t.string :card_number, null: false
      t.date :card_expiration, null: false
      t.string :card_cvv, null: false

      t.timestamps
    end
  end
end
