FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Movies::Hobbit.character }
    password { Faker::FunnyName.unique.name }
  end
end