class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :country
  belongs_to :city
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :user_name, presence: true
  validates :email_address, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :country_id, presence: true
  validates :city_id, presence: true
  validates :card_name, presence: true
  validates :card_number, presence: true
  validates :card_expiration, presence: true
  validates :card_cvv, presence: true
  
  def self.order_process(current_cart_items:, order:)
    success = true
    ActiveRecord::Base.transaction do
      # validationエラーの場合はtransactionを抜けて再入力を促す
      return false unless success = order.save
      # create!でエラーが起きた場合はrailsの共通処理に任せる
      current_cart_items.each do |item|
        order.order_items.create!({
          item_name: item.product.name,
          price: item.product.price,
          quantity: item.quantity
        })
      end
    end
    success
  end
end
