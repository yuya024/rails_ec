# frozen_string_literal: true

namespace :promotion_code do
  desc 'プロモーションコードを10個生成する'
  task generate: :environment do
    code_char = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten

    10.times do |_n|
      Promotion.create!({
                          code: code_char.sample(7).join,
                          discount: rand(100..1000)
                        })
    end
  end
end
