# frozen_string_literal: true

class CheckoutMailer < ApplicationMailer
  default from: 'checkout@example.com'

  def checkout_email(order)
    @order = order
    mail(to: @order.email_address, subject: 'ご注文完了メール')
  end
end
