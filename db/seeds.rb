# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

6.times do |n|
  Product.create!(
    name: "item#{n + 1}",
    description: "#{n + 1}番目の商品です",
    image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/item.jpg")), filename:"item.jpg"),
    price: 1000 + 100 * n
  )
end