FactoryBot.define do
  factory :message do
    body { Faker::Book.title }
    receiver_ids { [Faker::Number.digit] }
    seen { false }
  end
end