# frozen_string_literal: true

class Country < ApplicationRecord
  has_many :cities, dependent: :destroy
  has_one :order, dependent: :destroy
end
