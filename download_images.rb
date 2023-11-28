require 'open-uri'
require 'fileutils'

directory = 'download_images'
FileUtils.mkdir_p(directory) unless File.exist?(directory)

100.times do |i|
  image_url = 'https://picsum.photos/200'
  file_path = "#{directory}/image_#{i}.jpg"
  URI.open(image_url) do |image|
    File.open(file_path, 'wb') do |file|
      file.write(image.read)
    end
  end
end
