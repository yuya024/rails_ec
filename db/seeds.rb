# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

8.times do |n|
  product = Product.find_or_initialize_by(
    name: "item#{n + 1}",
    code: "SKU:BST-#{n + 1}"
  )
  product.description = "#{n + 1}番目の商品です"
  product.price = rand(500..1500)
  product.image_data = Base64.encode64(File.open('app/assets/images/item.jpg', 'rb').read)
  product.save!
end

countries = [
  { name: '日本'},
  { name: 'アメリカ'}
]

cities = [
  { name: '北海道', country: '日本' },
  { name: '青森', country: '日本' },
  { name: '岩手', country: '日本' },
  { name: '宮城', country: '日本' },
  { name: '秋田', country: '日本' },
  { name: '山形', country: '日本' },
  { name: '福島', country: '日本' },
  { name: '茨城', country: '日本' },
  { name: '栃木', country: '日本' },
  { name: '群馬', country: '日本' },
  { name: '埼玉', country: '日本' },
  { name: '千葉', country: '日本' },
  { name: '東京', country: '日本' },
  { name: '神奈川', country: '日本' },
  { name: '新潟', country: '日本' },
  { name: '富山', country: '日本' },
  { name: '石川', country: '日本' },
  { name: '福井', country: '日本' },
  { name: '山梨', country: '日本' },
  { name: '長野', country: '日本' },
  { name: '岐阜', country: '日本' },
  { name: '静岡', country: '日本' },
  { name: '愛知', country: '日本' },
  { name: '三重', country: '日本' },
  { name: '滋賀', country: '日本' },
  { name: '京都', country: '日本' },
  { name: '大阪', country: '日本' },
  { name: '兵庫', country: '日本' },
  { name: '奈良', country: '日本' },
  { name: '和歌山', country: '日本' },
  { name: '鳥取', country: '日本' },
  { name: '島根', country: '日本' },
  { name: '岡山', country: '日本' },
  { name: '広島', country: '日本' },
  { name: '山口', country: '日本' },
  { name: '徳島', country: '日本' },
  { name: '香川', country: '日本' },
  { name: '愛媛', country: '日本' },
  { name: '高知', country: '日本' },
  { name: '福岡', country: '日本' },
  { name: '佐賀', country: '日本' },
  { name: '長崎', country: '日本' },
  { name: '熊本', country: '日本' },
  { name: '大分', country: '日本' },
  { name: '宮崎', country: '日本' },
  { name: '鹿児島', country: '日本' },
  { name: '沖縄', country: '日本' },
  { name: 'ニューヨーク', country: 'アメリカ' },
  { name: 'カリフォルニア', country: 'アメリカ' },
  { name: 'イリノイ', country: 'アメリカ' }
]

countries.each do |c|
  country = Country.find_or_create_by(name: c[:name])
  country.save!
end

cities.each do |c|
  country = Country.find_by(name: c[:country])
  city = City.find_or_create_by(name: c[:name], country_id: country.id)
  city.save!
end