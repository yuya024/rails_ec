# frozen_string_literal: true

class Promotion < ApplicationRecord
  belongs_to :order, optional: true
end
