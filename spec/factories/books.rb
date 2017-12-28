FactoryBot.define do
  factory :book do |f|
    f.name Faker::Book.title
    f.author Faker::Book.author
    f.status 'in'
    f.genre Faker::Book.genre

  end
end
