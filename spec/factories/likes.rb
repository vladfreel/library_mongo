FactoryBot.define do
  factory :like do |f|
    f.association :book_id, factory: :book
  end
end