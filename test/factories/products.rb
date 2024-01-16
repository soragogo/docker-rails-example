# spec/factories/products.rb
FactoryBot.define do
    factory :product do
      name { "Sample Product" }
      category { 3 }
      price { 3000 }
      description { "Nice Sample Product!!!!" }
  
      # 画像ファイルのパスを指定しています
      image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'test', 'factories', 'skirt.jpeg'), 'image/jpeg') }
    end
  end
  