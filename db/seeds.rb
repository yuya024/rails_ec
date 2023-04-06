# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

6.times do |n|
  product = Product.new(
    name: "item#{n + 1}",
    description: "#{n + 1}番目の商品です",
    price: 1000 + 100 * n
  )
  product.image_data = Base64.encode64(File.open("app/assets/images/item.jpg", "rb").read)
  product.save!
end