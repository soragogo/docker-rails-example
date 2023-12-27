# `Active Storage`のアタッチメント用に`open-uri`を要求
require 'open-uri'

100.times do |i|
  product = Product.new(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence,
    category: Faker::Number.between(from: 0, to: 9),
    price: Faker::Commerce.price(range: 1000..10000),
    stock: Faker::Number.between(from: 1, to: 100)
  )

  # ダウンロードした画像のパス
  file_path = Rails.root.join('download_images', "image_#{i}.jpg")

  # 画像ファイルを開き、Active Storageを使ってアタッチ
  product.image.attach(io: File.open(file_path), filename: "image_#{i}.jpg")

  product.save!
end
