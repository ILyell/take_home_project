FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { Faker::Number.decimal(l_digits: 2, r_digits: 1) }
    brew_time { Faker::Number.decimal(l_digits: 1, r_digits: 2).to_s }
  end
end
