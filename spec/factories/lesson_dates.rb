# FactoryBot.define do
#   factory :lesson_date do
#     lesson_id
#     date { Faker::Date.forward(from: Date.current, days: 10) }
#     start_at { Faker::Time.between(from: Time.current.beginning_of_day, to: Time.current.end_of_day) }
#     end_at { Faker::Time.between(from: start_at, to: Time.current.end_of_day) }
#     capacity { rand(1..100) }
#     url { Faker::Lorem.word }
#   end
# end
