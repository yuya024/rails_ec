# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/checkout
class CheckoutPreview < ActionMailer::Preview
  def checkout_email
    @order = Order.first
    CheckoutMailer.checkout_email(@order)
  end
end
