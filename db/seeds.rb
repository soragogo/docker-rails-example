# `Active Storage`のアタッチメント用に`open-uri`を要求
require 'open-uri'

100.times do |i|
  product = Product.new(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence,
    category: Faker::Number.between(from: 1, to: 9),
    price: Faker::Commerce.price(range: 1000..10000),
    stock: Faker::Number.between(from: 1, to: 100)
  )

  # ダウンロードした画像のパス
  file_path = Rails.root.join('download_images', "image_#{i}.jpg")

  # 画像ファイルを開き、Active Storageを使ってアタッチ
  product.image.attach(io: File.open(file_path), filename: "image_#{i}.jpg")

  product.save!
end

# カスタマー情報を作成
Customer.create!(
  email: "emukamada@gmail.com",
  password: "password",
  name: "emukamada"
)

100.times do
  Customer.create!(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password,
    name: Faker::Name.name
  )
end

# ダミーでレビューを作成
reviewed_customers = Customer.pluck(:id)

100.times do |p|
  Review.create!(
    customer_id: reviewed_customers.sample,
    product_id: p + 1,
    star: Faker::Number.between(from: 1, to: 5),
    comment: Faker::Lorem.sentence
  )
end
