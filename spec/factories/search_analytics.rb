require 'faker'

FactoryBot.define do
    factory :search_analytics do
      query { Faker::Lorem.sentence }
      count { 0 }
    end
end