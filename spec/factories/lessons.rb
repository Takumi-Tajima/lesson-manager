FactoryBot.define do
  factory :lesson do
    name { Faker::Lorem.word }
    overview { Faker::Lorem.sentence(word_count: 25) }
    instructor { Faker::Name.name }
    publish { false }
  end
end
