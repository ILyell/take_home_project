FactoryBot.define do
  factory :subscription do
    tea_id {  }
    customer_id {}
    title { Faker::Tea.variety }
    price { Faker::Number.decimal(l_digits: 2, r_digits: 1) }
    status { 'pending' }
    frequency { "Often" }
  end
end
