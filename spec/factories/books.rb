FactoryBot.define do
  factory :book do |f|
    f.name Faker::Book.title
    f.author Faker::Book.author
    f.status 'in'
    f.img Rack::Test::UploadedFile.new('doska12.jpg')
    f.genre Faker::Book.genre
    f.description Faker::Lorem.sentence
  end
end
