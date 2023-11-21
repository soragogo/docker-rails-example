# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

name = Faker::Commerce.product_name  # 商品名
description = "This #{name.downcase} was worn by #{Faker::Name.name} in #{Faker::Date.backward(days: 365).year} in #{Faker::Address.city}"
price = Faker::Commerce.price(range: 1000..300000)  # 価格
stock = Faker::Number.between(from: 1, to: 10)  # 在庫