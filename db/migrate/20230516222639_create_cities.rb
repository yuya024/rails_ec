# frozen_string_literal: true

class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.references :country, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
