# frozen_string_literal: true

class City < ApplicationRecord
  belongs_to :country
  has_one :order, dependent: :destroy
end
