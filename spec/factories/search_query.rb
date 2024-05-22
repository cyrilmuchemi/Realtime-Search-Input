require 'faker'

FactoryBot.define do
    factory :search_query do
      query { Faker::Lorem.sentence }
      ip_address { Faker::Internet.ip_v4_address }
      user_identifier { SecureRandom.hex }
      completed { true }
    end
end