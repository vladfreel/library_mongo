FactoryBot.define do
  factory :comment do |f|
    f.body Faker::Lorem.sentence
    f.association :book_id, factory: :book
  end
end
